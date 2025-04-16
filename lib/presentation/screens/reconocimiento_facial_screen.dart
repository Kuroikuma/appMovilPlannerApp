import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../providers/use_case/reconocimiento_facial.dart';
import '../providers/use_case/trabajador.dart';
import '../providers/use_case/ubicacion.dart';
import '../utils/facial_recognition_utils_dos.dart';
import '../utils/notification_utils.dart';
import '../widget/face_detector_painter.dart';

class ReconocimientoFacialScreen extends ConsumerStatefulWidget {
  const ReconocimientoFacialScreen({super.key});

  @override
  ConsumerState<ReconocimientoFacialScreen> createState() =>
      _ReconocimientoFacialScreenState();
}

class _ReconocimientoFacialScreenState
    extends ConsumerState<ReconocimientoFacialScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isFrontCameraSelected = true;
  File? _imageFile;
  bool _isFlashOn = false;
  bool _isPermissionGranted = false;
  CustomPaint? customPaint;
  bool _isBusy = false;

  // Animation controller for the loading screen
  late AnimationController _animationController;

  // Timer para detectar inactividad
  Timer? _inactivityTimer;
  // Duración de inactividad antes de mostrar la pantalla (30 segundos)
  final Duration _inactivityDuration = const Duration(seconds: 30);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPermissionsAndInitCamera();
      _initFaceRecognition();
      _cargarTrabajadores();
      _startInactivityTimer();
    });
  }

  void _initFaceRecognition() async {
    ref.read(reconocimientoFacialNotifierProvider.notifier).reiniciarEstado();
    await ref.read(reconocimientoFacialNotifierProvider.notifier).initialize();
  }

  void _disposeFaceRecognition() {
    ref.read(reconocimientoFacialNotifierProvider.notifier).dispose();
  }

  void _cargarTrabajadores() {
    final ubicacionState = ref.read(ubicacionNotifierProvider);
    if (ubicacionState.ubicacion != null &&
        ubicacionState.ubicacion!.ubicacionId != null) {
      ref
          .read(trabajadorNotifierProvider.notifier)
          .cargarTrabajadores(ubicacionState.ubicacion!.ubicacionId.toString());
    } else {
      NotificationUtils.showSnackBar(
        context: context,
        message: 'No se pudo obtener la ID de la ubicación',
        isError: true,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeFaceRecognition();
    _cameraController?.dispose();
    _animationController.dispose();
    _inactivityTimer?.cancel();
    super.dispose();
  }

  // Iniciar el temporizador de inactividad
  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(_inactivityDuration, _onInactivity);
  }

  // Reiniciar el temporizador de inactividad
  void _resetInactivityTimer() {
    _startInactivityTimer();
  }

  // Función que se ejecuta cuando se detecta inactividad
  Future<void> _onInactivity() async {
    final currentState = ref.read(reconocimientoFacialNotifierProvider).estado;
    // Solo cambiar a inactivo si estamos en el estado inicial (cámara activa)
    if (currentState == ReconocimientoFacialEstado.inicial) {
      ref
          .read(reconocimientoFacialNotifierProvider.notifier)
          .cambiarEstado(ReconocimientoFacialEstado.inactivo);

      await _cameraController?.stopImageStream();
    }
  }

  // Reanudar la actividad
  Future<void> _resumeActivity() async {
    ref
        .read(reconocimientoFacialNotifierProvider.notifier)
        .cambiarEstado(ReconocimientoFacialEstado.inicial);

    await _cameraController?.startImageStream(_processCameraImage);

    _resetInactivityTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
      _inactivityTimer?.cancel();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
      _resetInactivityTimer();
    }
  }

  Future<void> _checkPermissionsAndInitCamera() async {
    final status = await Permission.camera.request();
    setState(() {
      _isPermissionGranted = status.isGranted;
    });

    if (status.isGranted) {
      await _initCamera();
    } else {
      NotificationUtils.showSnackBar(
        context: context,
        message: 'Se requiere permiso de cámara para el reconocimiento facial',
        isError: true,
        actionLabel: 'Configuración',
        onAction: () => openAppSettings(),
      );
    }
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();

      if (_cameras == null || _cameras!.isEmpty) {
        NotificationUtils.showSnackBar(
          context: context,
          message: 'No se encontraron cámaras disponibles',
          isError: true,
        );
        return;
      }

      // Seleccionar cámara frontal por defecto
      final frontCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();
      _cameraController!.startImageStream(_processCameraImage);

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      NotificationUtils.showSnackBar(
        context: context,
        message: 'Error al inicializar la cámara: $e',
        isError: true,
      );
    }
  }

  Future<void> _toggleCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    setState(() {
      _isFrontCameraSelected = !_isFrontCameraSelected;
      _isCameraInitialized = false;
    });

    final newCameraIndex =
        _isFrontCameraSelected
            ? _cameras!.indexWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
            )
            : _cameras!.indexWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back,
            );

    if (newCameraIndex != -1) {
      _cameraController?.dispose();

      _cameraController = CameraController(
        _cameras![newCameraIndex],
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }

      // Reiniciar el temporizador de inactividad al cambiar la cámara
      _resetInactivityTimer();
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    final state = ref.watch(reconocimientoFacialNotifierProvider);

    if (state.estado == ReconocimientoFacialEstado.exito ||
        state.estado == ReconocimientoFacialEstado.inactivo) {
      return;
    }

    if (_isBusy) return;

    final reconocimientoNotifier = ref.read(
      reconocimientoFacialNotifierProvider.notifier,
    );

    _isBusy = true;

    try {
      // Prepare input image
      final orientations = {
        DeviceOrientation.portraitUp: 0,
        DeviceOrientation.landscapeLeft: 90,
        DeviceOrientation.portraitDown: 180,
        DeviceOrientation.landscapeRight: 270,
      };

      final newCameraIndex =
          _isFrontCameraSelected
              ? _cameras!.indexWhere(
                (camera) => camera.lensDirection == CameraLensDirection.front,
              )
              : _cameras!.indexWhere(
                (camera) => camera.lensDirection == CameraLensDirection.back,
              );

      final camera = _cameras![newCameraIndex];

      InputImageRotation? rotation;
      if (Platform.isIOS) {
        rotation = InputImageRotationValue.fromRawValue(
          camera.sensorOrientation,
        );
      } else {
        var rotationCompensation =
            orientations[_cameraController!.value.deviceOrientation];
        if (rotationCompensation == null) return;
        if (camera.lensDirection == CameraLensDirection.front) {
          rotationCompensation =
              (camera.sensorOrientation + rotationCompensation) % 360;
        } else {
          rotationCompensation =
              (camera.sensorOrientation - rotationCompensation + 360) % 360;
        }
        rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      }
      if (rotation == null) return;
      final format = InputImageFormatValue.fromRawValue(image.format.raw);
      if (format == null) return;

      final yPlane = image.planes[0].bytes;
      final uvPlane = image.planes[1].bytes;

      final buffer = Uint8List(yPlane.length + uvPlane.length);
      buffer.setRange(0, yPlane.length, yPlane);
      buffer.setRange(yPlane.length, buffer.length, uvPlane);

      InputImage inputImage = InputImage.fromBytes(
        bytes: buffer,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: InputImageFormat.nv21,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      // Detect faces
      final faces = await reconocimientoNotifier.detectFaces(inputImage);
      if (faces.isEmpty) {
        if (mounted) {
          setState(() => customPaint = null);
        }
        _isBusy = false;

        return;
      }

      // Reiniciar el temporizador de inactividad
      _resetInactivityTimer();

      final nv21Data = FacialRecognitionUtilsDos.yuv420ToNv21(image);

      // Prepare input list
      List input =
          await compute(FacialRecognitionUtilsDos.prepareInputFromNV21, {
            'nv21Data': nv21Data,
            'width': image.width,
            'height': image.height,
            'isFrontCamera': camera.lensDirection == CameraLensDirection.front,
            'face': faces.first,
          });

      // Get embedding
      final embedding = reconocimientoNotifier.getEmbedding(input);
      // Identify the face
      final name = await reconocimientoNotifier.identifyFace(embedding);
      // Update UI
      if (mounted) {
        setState(() {
          customPaint = CustomPaint(
            painter: FaceDetectorPainter(
              faces,
              inputImage.metadata!.size,
              inputImage.metadata!.rotation,
              camera.lensDirection,
              name,
            ),
          );
        });
      }
    } finally {
      _isBusy = false;
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      if (_isFlashOn) {
        await _cameraController!.setFlashMode(FlashMode.off);
      } else {
        await _cameraController!.setFlashMode(FlashMode.torch);
      }

      setState(() {
        _isFlashOn = !_isFlashOn;
      });

      // Reiniciar el temporizador de inactividad al cambiar el flash
      _resetInactivityTimer();
    } catch (e) {
      NotificationUtils.showSnackBar(
        context: context,
        message: 'Error al cambiar el flash: $e',
        isError: true,
      );
    }
  }

  Future<void> _captureImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      ref
          .read(reconocimientoFacialNotifierProvider.notifier)
          .cambiarEstado(ReconocimientoFacialEstado.capturando);

      final XFile image = await _cameraController!.takePicture();

      setState(() {
        _imageFile = File(image.path);
      });

      // Convertir la imagen a base64
      final bytes = await _imageFile!.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Procesar la imagen
      await _procesarImagen(base64Image);

      // Cancelar el temporizador de inactividad al capturar una imagen
      _inactivityTimer?.cancel();
    } catch (e) {
      ref
          .read(reconocimientoFacialNotifierProvider.notifier)
          .cambiarEstado(ReconocimientoFacialEstado.error);

      NotificationUtils.showSnackBar(
        context: context,
        message: 'Error al capturar la imagen: $e',
        isError: true,
      );
    }
  }

  Future<void> _seleccionarImagen() async {
    ref
        .read(reconocimientoFacialNotifierProvider.notifier)
        .cambiarEstado(ReconocimientoFacialEstado.capturando);

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });

        // Convertir la imagen a base64
        final bytes = await _imageFile!.readAsBytes();
        final base64Image = base64Encode(bytes);

        // Procesar la imagen
        await _procesarImagen(base64Image);
        // Cancelar el temporizador de inactividad al seleccionar una imagen
        _inactivityTimer?.cancel();
      } else {
        // El usuario canceló la selección
        ref
            .read(reconocimientoFacialNotifierProvider.notifier)
            .cambiarEstado(ReconocimientoFacialEstado.inicial);

        // Reiniciar el temporizador de inactividad
        _resetInactivityTimer();
        print('_seleccionarImagen');
      }
    } catch (e) {
      ref
          .read(reconocimientoFacialNotifierProvider.notifier)
          .cambiarEstado(ReconocimientoFacialEstado.error);

      NotificationUtils.showSnackBar(
        context: context,
        message: 'Error al seleccionar la imagen: $e',
        isError: true,
      );
    }
  }

  Future<void> _procesarImagen(String base64Image) async {
    // Identificar al trabajador
    await ref
        .read(reconocimientoFacialNotifierProvider.notifier)
        .identificarTrabajador(base64Image);
  }

  Future<void> _registrarAsistencia() async {
    await ref
        .read(reconocimientoFacialNotifierProvider.notifier)
        .registrarAsistenciaPorReconocimiento();
  }

  void _reiniciarProceso() {
    setState(() {
      _imageFile = null;
    });

    ref.read(reconocimientoFacialNotifierProvider.notifier).reiniciarEstado();

    // Reiniciar el temporizador de inactividad
    _resetInactivityTimer();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reconocimientoFacialNotifierProvider);
    final theme = Theme.of(context);

    // Mostrar notificación si hay error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.errorMessage != null) {
        NotificationUtils.showSnackBar(
          context: context,
          message: state.errorMessage!,
          isError: true,
        );
        // Limpiar el error después de mostrarlo
        ref.read(reconocimientoFacialNotifierProvider.notifier).clearErrors();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reconocimiento Facial'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed:
                state.estado == ReconocimientoFacialEstado.inicial ||
                        state.estado == ReconocimientoFacialEstado.inactivo
                    ? _seleccionarImagen
                    : null,
            tooltip: 'Seleccionar de galería',
          ),
        ],
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, ReconocimientoFacialStateData state) {
    switch (state.estado) {
      case ReconocimientoFacialEstado.inicial:
        return _buildCameraPreview(context);
      case ReconocimientoFacialEstado.capturando:
        return _buildCapturando(context);
      case ReconocimientoFacialEstado.procesando:
        return _buildProcesando(context);
      case ReconocimientoFacialEstado.exito:
        return _buildExito(context, state);
      case ReconocimientoFacialEstado.error:
        return _buildError(context, state.errorMessage ?? 'Error desconocido');
      case ReconocimientoFacialEstado.inactivo:
        return _buildInactivo(context);
      default:
        return _buildCameraPreview(context);
    }
  }

  // Nueva pantalla para el estado de inactividad
  Widget _buildInactivo(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.hourglass_empty,
                    color: theme.colorScheme.onPrimary,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Sistema en Espera',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated icon
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animationController.value * 2 * math.pi,
                          child: Icon(
                            Icons.timelapse,
                            size: 100,
                            color: theme.colorScheme.primary.withOpacity(0.7),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Mensaje de inactividad
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Sistema en espera por inactividad',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Descripción
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'No se ha detectado actividad en los últimos 30 segundos. El sistema de reconocimiento facial está en pausa.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.colorScheme.onBackground.withOpacity(
                            0.7,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Botón para reanudar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: FilledButton.icon(
                        onPressed: _resumeActivity,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Reanudar Reconocimiento Facial'),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Consejos
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: theme.colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Consejos',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Para un mejor reconocimiento facial, asegúrate de estar en un lugar bien iluminado y mantener tu rostro centrado en la pantalla.',
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.colorScheme.onBackground.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    if (!_isPermissionGranted) {
      return _buildPermissionDenied(context);
    }

    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        color: theme.colorScheme.primary.withOpacity(0.1),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    // Calcular la relación de aspecto de la cámara
    final scale = 1 / (_cameraController!.value.aspectRatio * size.aspectRatio);

    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: Column(
        children: [
          // Instrucciones
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            color: theme.colorScheme.primary,
            child: Text(
              'Coloca tu rostro dentro del marco y presiona el botón para capturar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Vista de la cámara
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Vista previa de la cámara con ajuste de escala
                    Transform.scale(
                      scale: scale,
                      alignment: Alignment.center,
                      child: Center(
                        child: CameraPreview(
                          _cameraController!,
                          child: customPaint,
                        ),
                      ),
                    ),

                    // Guía para el rostro
                    Positioned.fill(
                      child: CustomPaint(painter: FaceGuideOverlay()),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Controles de cámara
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            color: theme.colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón de flash
                _buildControlButton(
                  icon: _isFlashOn ? Icons.flash_on : Icons.flash_off,
                  onPressed: _toggleFlash,
                  label: _isFlashOn ? 'Flash On' : 'Flash Off',
                ),

                // Botón de captura
                GestureDetector(
                  onTap: _captureImage,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.onPrimary,
                        width: 3,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.onPrimary,
                      ),
                      margin: const EdgeInsets.all(8),
                    ),
                  ),
                ),

                // Botón para cambiar de cámara
                _buildControlButton(
                  icon: Icons.flip_camera_ios,
                  onPressed: _toggleCamera,
                  label: 'Cambiar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String label,
  }) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: theme.colorScheme.onPrimary, size: 28),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPermissionDenied(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_photography,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Permiso de cámara denegado',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Se requiere acceso a la cámara para utilizar el reconocimiento facial',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => openAppSettings(),
              icon: const Icon(Icons.settings),
              label: const Text('Abrir configuración'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCapturando(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: theme.colorScheme.primary),
            const SizedBox(height: 24),
            Text(
              'Capturando imagen...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcesando(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null) ...[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.file(
                    _imageFile!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            CircularProgressIndicator(color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Procesando reconocimiento facial...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Esto puede tomar unos segundos',
              style: TextStyle(
                color: theme.colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExito(
    BuildContext context,
    ReconocimientoFacialStateData state,
  ) {
    final theme = Theme.of(context);
    final trabajador = state.trabajadorIdentificado;

    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, size: 64, color: Colors.green[700]),
                  const SizedBox(height: 16),
                  Text(
                    '¡Reconocimiento Exitoso!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            if (trabajador != null) ...[
              CircleAvatar(
                radius: 60,
                backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                backgroundImage:
                    trabajador.fotoUrl != null
                        ? FileImage(File(trabajador.fotoUrl))
                        : null,
                child:
                    trabajador.fotoUrl == null
                        ? Text(
                          trabajador.nombre[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 40,
                            color: theme.colorScheme.primary,
                          ),
                        )
                        : null,
              ),
              const SizedBox(height: 16),
              Text(
                trabajador.nombre,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              if (trabajador.primerApellido != null) ...[
                const SizedBox(height: 8),
                Text(
                  '${trabajador.primerApellido} ${trabajador.segundoApellido}',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 32),

              // Información de registro
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Información de Registro',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Fecha: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                          style: TextStyle(
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Hora: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),

            if (!state.registroExitoso) ...[
              FilledButton.icon(
                onPressed: _registrarAsistencia,
                icon: const Icon(Icons.check),
                label: const Text('Registrar Asistencia'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Asistencia registrada correctamente',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: _reiniciarProceso,
              icon: const Icon(Icons.refresh),
              label: const Text('Reiniciar Proceso'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                foregroundColor: theme.colorScheme.primary,
                side: BorderSide(color: theme.colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String errorMessage) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                'Error en el Reconocimiento',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: _reiniciarProceso,
                icon: const Icon(Icons.refresh),
                label: const Text('Intentar Nuevamente'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Clase para dibujar la guía para el rostro
class FaceGuideOverlay extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

    // Dibujar un óvalo para guiar la posición del rostro
    final center = Offset(size.width / 2, size.height / 2);
    final radiusX = size.width * 0.35;
    final radiusY = size.height * 0.4;

    canvas.drawOval(
      Rect.fromCenter(center: center, width: radiusX * 2, height: radiusY * 2),
      paint,
    );

    // Dibujar líneas de guía
    final dashPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    // Línea horizontal
    canvas.drawLine(
      Offset(center.dx - radiusX - 20, center.dy),
      Offset(center.dx + radiusX + 20, center.dy),
      dashPaint,
    );

    // Línea vertical
    canvas.drawLine(
      Offset(center.dx, center.dy - radiusY - 20),
      Offset(center.dx, center.dy + radiusY + 20),
      dashPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
