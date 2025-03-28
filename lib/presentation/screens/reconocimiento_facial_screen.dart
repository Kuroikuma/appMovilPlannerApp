import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/use_case/reconocimiento_facial.dart';
import '../utils/notification_utils.dart';

class ReconocimientoFacialScreen extends ConsumerStatefulWidget {
  const ReconocimientoFacialScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ReconocimientoFacialScreen> createState() =>
      _ReconocimientoFacialScreenState();
}

class _ReconocimientoFacialScreenState
    extends ConsumerState<ReconocimientoFacialScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  bool _isCameraMode = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reconocimientoFacialNotifierProvider.notifier).reiniciarEstado();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reconocimientoFacialNotifierProvider);

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
        actions: [
          IconButton(
            icon: Icon(_isCameraMode ? Icons.photo_library : Icons.camera_alt),
            onPressed: () {
              setState(() {
                _isCameraMode = !_isCameraMode;
              });
            },
            tooltip: _isCameraMode ? 'Seleccionar de galería' : 'Usar cámara',
          ),
        ],
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, ReconocimientoFacialStateData state) {
    switch (state.estado) {
      case ReconocimientoFacialEstado.inicial:
        return _buildCapturaInicial(context);
      case ReconocimientoFacialEstado.capturando:
        return _buildCapturando(context);
      case ReconocimientoFacialEstado.procesando:
        return _buildProcesando(context);
      case ReconocimientoFacialEstado.exito:
        return _buildExito(context, state);
      case ReconocimientoFacialEstado.error:
        return _buildError(context, state.errorMessage ?? 'Error desconocido');
      default:
        return _buildCapturaInicial(context);
    }
  }

  Widget _buildCapturaInicial(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.face,
            size: 100,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ),
          const SizedBox(height: 24),
          Text(
            'Reconocimiento Facial',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Captura tu rostro para registrar tu asistencia de forma rápida y segura.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: _capturarImagen,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Capturar Imagen'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _seleccionarImagen,
            icon: const Icon(Icons.photo_library),
            label: const Text('Seleccionar de Galería'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCapturando(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 24),
          Text(
            'Capturando imagen...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildProcesando(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_imageFile != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                _imageFile!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
          ],
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Procesando reconocimiento facial...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Esto puede tomar unos segundos',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildExito(
    BuildContext context,
    ReconocimientoFacialStateData state,
  ) {
    final trabajador = state.trabajadorIdentificado;

    return SingleChildScrollView(
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
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
              backgroundImage:
                  trabajador.fotoUrl != null
                      ? NetworkImage(trabajador.fotoUrl!)
                      : null,
              child:
                  trabajador.fotoUrl == null
                      ? Text(
                        trabajador.nombre[0].toUpperCase(),
                        style: const TextStyle(fontSize: 40),
                      )
                      : null,
            ),
            const SizedBox(height: 16),
            Text(
              trabajador.nombre,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (trabajador.primerApellido != null) ...[
              const SizedBox(height: 8),
              Text(
                trabajador.primerApellido,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
            if (trabajador.segundoApellido != null) ...[
              const SizedBox(height: 4),
              Text(
                trabajador.segundoApellido!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 32),

            // Información de registro
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Información de Registro',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Fecha: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        style: Theme.of(context).textTheme.bodyMedium,
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Hora: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.bodyMedium,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 24),
            Text(
              'Error en el Reconocimiento',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _reiniciarProceso,
              icon: const Icon(Icons.refresh),
              label: const Text('Intentar Nuevamente'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _capturarImagen() async {
    ref
        .read(reconocimientoFacialNotifierProvider.notifier)
        .cambiarEstado(ReconocimientoFacialEstado.capturando);

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
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
      } else {
        // El usuario canceló la captura
        ref
            .read(reconocimientoFacialNotifierProvider.notifier)
            .cambiarEstado(ReconocimientoFacialEstado.inicial);
      }
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
      final XFile? image = await _picker.pickImage(
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
      } else {
        // El usuario canceló la selección
        ref
            .read(reconocimientoFacialNotifierProvider.notifier)
            .cambiarEstado(ReconocimientoFacialEstado.inicial);
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
  }
}
