import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.imageSize, this.results);
  final Size imageSize;
  late double scaleX, scaleY;
  final Map<String, List<Face>> results; // ✅ Tipado explícito (null safety)

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..color = Colors.greenAccent;

    for (final label in results.keys) {
      for (final face in results[label]!) {
        // ✅ Null check con '!'
        scaleX = size.width / imageSize.width;
        scaleY = size.height / imageSize.height;

        canvas.drawRRect(
          _scaleRect(
            rect: face.boundingBox,
            imageSize: imageSize,
            widgetSize: size,
            scaleX: scaleX,
            scaleY: scaleY,
          ),
          paint,
        );

        final span = TextSpan(
          // ✅ Null safety en color
          style: TextStyle(
            color: Colors.orange[300] ?? Colors.orange, // Fallback si es null
            fontSize: 15,
          ),
          text: label,
        );

        final textPainter = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            size.width - (60 + face.boundingBox.left) * scaleX,
            (face.boundingBox.top - 10) * scaleY,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize ||
        !mapEquals(oldDelegate.results, results); // ✅ Comparación de mapas
  }
}

RRect _scaleRect({
  required Rect rect,
  required Size imageSize,
  required Size widgetSize,
  required double scaleX,
  required double scaleY,
}) {
  return RRect.fromLTRBR(
    widgetSize.width - rect.left * scaleX,
    rect.top * scaleY,
    widgetSize.width - rect.right * scaleX,
    rect.bottom * scaleY,
    const Radius.circular(10),
  );
}
