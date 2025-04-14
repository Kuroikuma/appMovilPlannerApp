import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class FacialRecognitionUtilsDos {
  //detecttor de rostros app vieja
  static List prepareInputFromNV21(Map<String, dynamic> params) {
    final nv21Data = params['nv21Data'] as Uint8List;
    final width = params['width'] as int;
    final height = params['height'] as int;
    final isFrontCamera = params['isFrontCamera'] as bool;
    final face = params['face'] as Face;

    img.Image image = convertNV21ToImage(nv21Data, width, height);
    image = img.copyRotate(image, angle: isFrontCamera ? -90 : 90);

    return prepareInput(image, face);
  }

  static List prepareInputFromImagePath(Map<String, dynamic> params) {
    final imgPath = params['imgPath'] as String;
    final face = params['face'] as Face;

    img.Image image = img.decodeImage(File(imgPath).readAsBytesSync())!;
    return prepareInput(image, face);
  }

  static List prepareInput(img.Image image, Face face) {
    int x, y, w, h;
    x = face.boundingBox.left.round();
    y = face.boundingBox.top.round();
    w = face.boundingBox.width.round();
    h = face.boundingBox.height.round();

    img.Image faceImage = img.copyCrop(image, x: x, y: y, width: w, height: h);
    img.Image resizedImage = img.copyResizeCropSquare(faceImage, size: 112);

    // Save cropped face image
    // final docDir = await getApplicationDocumentsDirectory();
    // final file = File('${docDir.path}/${face.hashCode}.jpg');
    // await file.writeAsBytes(img.encodeJpg(resizedImage));

    List input = _imageToByteListFloat32(resizedImage, 112, 127.5, 127.5);
    input = input.reshape([1, 112, 112, 3]);

    return input;
  }

  static List _imageToByteListFloat32(
    img.Image image,
    int size,
    double mean,
    double std,
  ) {
    var convertedBytes = Float32List(1 * size * size * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < size; i++) {
      for (var j = 0; j < size; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (pixel.r - mean) / std;
        buffer[pixelIndex++] = (pixel.g - mean) / std;
        buffer[pixelIndex++] = (pixel.b - mean) / std;
      }
    }
    return convertedBytes.toList();
  }

  static img.Image convertNV21ToImage(
    Uint8List nv21Data,
    int width,
    int height,
  ) {
    img.Image image = img.Image(width: width, height: height);
    final ySize = width * height;
    final uvSize = width * height ~/ 4;

    final yPlane = nv21Data.sublist(0, ySize);
    final uvPlane = nv21Data.sublist(ySize, ySize + uvSize * 2);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final yIndex = y * width + x;
        final yValue = yPlane[yIndex];

        final uvIndex = (y ~/ 2) * width + (x - (x % 2));
        final vValue = uvPlane[uvIndex];
        final uValue = uvPlane[uvIndex + 1];

        final r = (yValue + 1.402 * (vValue - 128)).clamp(0, 255).toInt();
        final g =
            (yValue - 0.34414 * (uValue - 128) - 0.71414 * (vValue - 128))
                .clamp(0, 255)
                .toInt();
        final b = (yValue + 1.772 * (uValue - 128)).clamp(0, 255).toInt();

        image.setPixel(x, y, img.ColorRgb8(r, g, b));
      }
    }

    return image;
  }

  static Uint8List yuv420ToNv21(CameraImage image) {
    final int width = image.width;
    final int height = image.height;

    final Uint8List yPlane = image.planes[0].bytes;
    final Uint8List uPlane = image.planes[1].bytes;
    final Uint8List vPlane = image.planes[2].bytes;

    final int ySize = width * height;
    final int uvSize = (width * height) ~/ 4;

    final Uint8List nv21 = Uint8List(ySize + uvSize * 2);

    // Copiar plano Y
    nv21.setRange(0, ySize, yPlane);

    // Intercalar planos V y U
    int uvIndex = ySize;
    for (int i = 0; i < uvSize; i++) {
      nv21[uvIndex++] = vPlane[i];
      nv21[uvIndex++] = uPlane[i];
    }

    return nv21;
  }
}
