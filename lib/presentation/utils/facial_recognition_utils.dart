import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart'; // ✅ Cambio de import
import 'package:image/image.dart' as imglib;

// ✅ Actualizado para usar InputImage en lugar de FirebaseVisionImage
typedef HandleDetection = Future<dynamic> Function(InputImage image);

enum Choice { view, delete }

Future<CameraDescription> getCamera(CameraLensDirection dir) async {
  return await availableCameras().then(
    (List<CameraDescription> cameras) => cameras.firstWhere(
      (CameraDescription camera) => camera.lensDirection == dir,
    ),
  );
}

// ✅ Cambiado a InputImageRotation
InputImageRotation rotationIntToImageRotation(int rotation) {
  switch (rotation) {
    case 0:
      return InputImageRotation.rotation0deg;
    case 90:
      return InputImageRotation.rotation90deg;
    case 180:
      return InputImageRotation.rotation180deg;
    case 270:
      return InputImageRotation.rotation270deg;
    default:
      return InputImageRotation.rotation0deg;
  }
}

// ✅ Función detect actualizada para usar InputImage
Future<dynamic> detect(
  CameraImage image,
  HandleDetection handleDetection,
  InputImageRotation rotation,
) async {
  final WriteBuffer allBytes = WriteBuffer();

  for (final Plane plane in image.planes) {
    allBytes.putUint8List(plane.bytes);
  }
  final bytes = allBytes.done().buffer.asUint8List();

  final inputImage = InputImage.fromBytes(
    bytes: bytes,
    metadata: InputImageMetadata(
      // ✅ Clase correcta: InputImageMetadata
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      format: _getInputImageFormat(
        image.format,
      ), // ✅ Usa el helper para el formato
      bytesPerRow: image.planes[0].bytesPerRow,
    ),
  );

  return handleDetection(inputImage);
}

// ✅ Helper para determinar el formato de la imagen
InputImageFormat _getInputImageFormat(ImageFormat format) {
  if (Platform.isAndroid) return InputImageFormat.nv21; // Android
  if (Platform.isIOS) return InputImageFormat.bgra8888; // iOS
  return InputImageFormat.nv21; // Default
}

// ✅ Funciones restantes (sin cambios, excepto null safety)
Float32List imageToByteListFloat32(
  imglib.Image image,
  int inputSize,
  double mean,
  double std,
) {
  final convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  final buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;

  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      final pixel = image.getPixel(j, i);
      // Acceder a los canales directamente desde el objeto Pixel
      buffer[pixelIndex++] = (pixel.r - mean) / std;
      buffer[pixelIndex++] = (pixel.g - mean) / std;
      buffer[pixelIndex++] = (pixel.b - mean) / std;
    }
  }

  return convertedBytes;
}

double euclideanDistance(List<double> e1, List<double> e2) {
  // ✅ Null safety
  double sum = 0.0;
  for (int i = 0; i < e1.length; i++) {
    sum += pow((e1[i] - e2[i]), 2);
  }
  return sqrt(sum);
}

Future<InputImage> cameraImageToInputImage(
  CameraImage image,
  InputImageRotation rotation,
) async {
  final format = _getInputImageFormat(image.format);

  if (Platform.isAndroid && format == InputImageFormat.nv21) {
    // ✅ Combinar planos Y y UV para NV21
    final yPlane = image.planes[0].bytes;
    final uvPlane = image.planes[1].bytes;

    final buffer = Uint8List(yPlane.length + uvPlane.length);
    buffer.setRange(0, yPlane.length, yPlane);
    buffer.setRange(yPlane.length, buffer.length, uvPlane);

    return InputImage.fromBytes(
      bytes: buffer,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );
  }

  // Resto del código para iOS/otros formatos
  final plane = image.planes.first;
  return InputImage.fromBytes(
    bytes: plane.bytes,
    metadata: InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      format: format,
      bytesPerRow: plane.bytesPerRow,
    ),
  );
}
