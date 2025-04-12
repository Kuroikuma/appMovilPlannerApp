import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/facial_recognition_utils.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:quiver/collection.dart';
import 'package:flutter/services.dart';

import '../utils/notification_utils.dart';
import '../widget/face_detector_painter.dart';

class FaceRecognitionScreen extends ConsumerStatefulWidget {
  const FaceRecognitionScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<FaceRecognitionScreen> createState() =>
      _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends ConsumerState<FaceRecognitionScreen>
    with WidgetsBindingObserver {
  File? jsonFile;
  dynamic _scanResults;
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  var interpreter;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.front;
  dynamic data = {};
  double threshold = 1.0;
  Directory? tempDir;
  List<double>? e1; // ✅ Null safety
  bool _faceFound = false;
  final TextEditingController _name = TextEditingController();
  FaceDetector? _faceDetector; // ✅ Detector de ML Kit
  bool _isPermissionGranted = false;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermissionsAndInitCamera();
    final options = FaceDetectorOptions(performanceMode: FaceDetectorMode.fast);
    _faceDetector = FaceDetector(options: options);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // _initializeCamera();
  }

  Future<void> _checkPermissionsAndInitCamera() async {
    final status = await Permission.camera.request();
    setState(() {
      _isPermissionGranted = status.isGranted;
    });

    if (status.isGranted) {
      await _initializeCamera();
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

  Future<void> loadModel() async {
    try {
      // Crear la nueva instancia del delegado GPU
      final gpuDelegateV2 = tfl.GpuDelegateV2(
        options: tfl.GpuDelegateOptionsV2(),
      );

      // Configurar las opciones del intérprete
      var interpreterOptions =
          tfl.InterpreterOptions()..addDelegate(gpuDelegateV2);

      // Cargar el modelo con las nuevas opciones
      interpreter = await tfl.Interpreter.fromAsset(
        'mobilefacenet.tflite',
        options: interpreterOptions,
      );

      print('Modelo cargado correctamente.');
    } catch (e) {
      print('Error al cargar el modelo: $e');
    }
  }

  Future<void> _initializeCamera() async {
    await loadModel();
    final description = await getCamera(_direction);

    final rotation = rotationIntToImageRotation(
      // ✅ Usa InputImageRotation
      description.sensorOrientation,
    );

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
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.nv21,
    );

    await _cameraController!.initialize();

    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }

    await Future.delayed(const Duration(milliseconds: 500));

    // Cargar datos desde un archivo JSON
    tempDir = await getApplicationDocumentsDirectory();
    String embPath = '${tempDir?.path}/emb.json';
    jsonFile = File(embPath);
    if (jsonFile!.existsSync()) {
      data = json.decode(jsonFile!.readAsStringSync());
    }

    _cameraController!.startImageStream((CameraImage image) async {
      if (_isDetecting) return;
      _isDetecting = true;
      print(interpreter);

      final finalResult = Multimap<String, Face>();
      try {
        final faces = await detect(image, rotation); // ✅ Nueva implementación
        print('faces - $faces');
        _faceFound = faces.isNotEmpty;
        if (!_faceFound) return;
        final convertedImage = _convertCameraImage(image, _direction);
        for (final face in faces) {
          final croppedImage = _cropFace(convertedImage, face);
          final res = _recog(croppedImage);
          finalResult.add(res, face);
        }

        setState(() => _scanResults = finalResult);
      } finally {
        _isDetecting = false;
      }
    });
  }

  imglib.Image _convertCameraImage(CameraImage image, CameraLensDirection dir) {
    final width = image.width;
    final height = image.height;
    final img = imglib.Image(width: width, height: height);
    final planeY = image.planes[0].bytes;
    final planeU = image.planes[1].bytes;
    final planeV = image.planes[2].bytes;

    // Correct YUV to RGB conversion using BT.601 coefficients
    // Reemplaza el bucle de conversión con esta implementación probada:
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final uvIndex = (x ~/ 2) + (y ~/ 2) * (width ~/ 2);
        final yValue = planeY[y * width + x];
        final uValue = planeU[uvIndex] - 128;
        final vValue = planeV[uvIndex] - 128;

        // Fórmula YUV to RGB (BT.601)
        int r = (yValue + (1.402 * vValue)).clamp(0, 255).toInt();
        int g =
            (yValue - (0.344 * uValue) - (0.714 * vValue))
                .clamp(0, 255)
                .toInt();
        int b = (yValue + (1.772 * uValue)).clamp(0, 255).toInt();

        img.setPixelRgb(x, y, r, g, b);
      }
    }

    // Handle mirroring for front camera
    final rotated = imglib.copyRotate(img, angle: -90);
    return dir == CameraLensDirection.front
        ? imglib.flipHorizontal(rotated)
        : rotated;
  }

  // ✅ Nueva función detect usando ML Kit
  Future<List<Face>> detect(
    CameraImage image,
    InputImageRotation rotation,
  ) async {
    final inputImage = await cameraImageToInputImage(image, rotation);
    return await _faceDetector!.processImage(inputImage);
  }

  Widget _buildImage() {
    if (!_isCameraInitialized || _cameraController == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      constraints: const BoxConstraints.expand(),
      child:
          _cameraController == null
              ? const Center(child: null)
              : Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CameraPreview(_cameraController!),
                  _buildResults(),
                ],
              ),
    );
  }

  void _toggleCameraDirection() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }
    await _cameraController!.stopImageStream();
    await _cameraController!.dispose();

    setState(() {
      _cameraController = null;
    });

    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face recognition'),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: (Choice result) {
              if (result == Choice.delete)
                _resetFile();
              else
                _viewLabels();
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<Choice>>[
                  const PopupMenuItem<Choice>(
                    child: Text('View Saved Faces'),
                    value: Choice.view,
                  ),
                  const PopupMenuItem<Choice>(
                    child: Text('Remove all faces'),
                    value: Choice.delete,
                  ),
                ],
          ),
        ],
      ),
      body: _buildImage(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: (_faceFound) ? Colors.blue : Colors.blueGrey,
            child: Icon(Icons.add),
            onPressed: () {
              if (_faceFound) _addLabel();
            },
            heroTag: null,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _toggleCameraDirection,
            heroTag: null,
            child:
                _direction == CameraLensDirection.back
                    ? const Icon(Icons.camera_front)
                    : const Icon(Icons.camera_rear),
          ),
        ],
      ),
    );
  }

  void _addLabel() {
    setState(() {
      _cameraController = null;
    });
    print("Adding new face");
    var alert = new AlertDialog(
      title: new Text("Add Face"),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _name,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: "Name",
                icon: new Icon(Icons.face),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FilledButton.icon(
          onPressed: () {
            _handle(_name.text.toUpperCase());
            _name.clear();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.save),
          label: const Text('Save'),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        FilledButton.icon(
          onPressed: () {
            _initializeCamera();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.cancel),
          label: const Text('Cancel'),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  Widget _buildResults() {
    const Text noResultsText = const Text('');
    if (_scanResults == null ||
        _cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return noResultsText;
    }
    CustomPainter painter;
    print('aqui esta el resultado del escanner');
    print(_scanResults);

    final Size imageSize = Size(
      _cameraController!.value.previewSize!.height,
      _cameraController!.value.previewSize!.width,
    );
    painter = FaceDetectorPainter(imageSize, _scanResults);
    return CustomPaint(painter: painter);
  }

  imglib.Image _cropFace(imglib.Image convertedImage, Face face) {
    final rect = face.boundingBox;
    return imglib.copyCrop(
      convertedImage,
      x: (rect.left - 10).round(),
      y: (rect.top - 10).round(),
      width: (rect.width + 20).round(),
      height: (rect.height + 20).round(),
    );
  }

  String _recog(imglib.Image img) {
    final input = imageToByteListFloat32(img, 112, 128, 128);
    final output = List<double>.filled(192, 0);

    interpreter.run(input.reshape([1, 112, 112, 3]), output);

    e1 = output;
    return compare(e1!).toUpperCase();
  }

  String compare(List<double> currEmb) {
    // ✅ Especifica List<double>
    if (data.isEmpty) return "No Face saved";
    double minDist = 999;
    double currDist = 0.0;
    String predRes = "NOT RECOGNIZED";

    for (final label in data.keys) {
      final savedEmb = List<double>.from(data[label]); // ✅ Conversión explícita
      currDist = euclideanDistance(savedEmb, currEmb);

      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predRes = label;
      }
    }

    print("$minDist $predRes");
    return predRes;
  }

  @override
  void dispose() {
    _faceDetector!.close(); // ✅ Cierra el detector
    _cameraController?.dispose();
    super.dispose();
  }

  void _handle(String text) {
    data[text] = e1;
    jsonFile!.writeAsStringSync(json.encode(data));
    _initializeCamera();
  }

  void _resetFile() {
    data = {};
    setState(() {});
    jsonFile!.deleteSync();
  }

  void _viewLabels() {
    setState(() {
      _cameraController = null;
    });
    String name;
    var alert = new AlertDialog(
      title: new Text("Saved Faces"),
      content: new ListView.builder(
        padding: new EdgeInsets.all(2),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          name = data.keys.elementAt(index);
          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(
                  name,
                  style: new TextStyle(fontSize: 14, color: Colors.grey[400]),
                ),
              ),
              new Padding(padding: EdgeInsets.all(2)),
              new Divider(),
            ],
          );
        },
      ),
      actions: <Widget>[
        FilledButton.icon(
          onPressed: () {
            _initializeCamera();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text('Ok'),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }
}
