import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

double translateX(
  double x,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      return x *
          canvasSize.width /
          (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation270deg:
      return canvasSize.width -
          x *
              canvasSize.width /
              (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      switch (cameraLensDirection) {
        case CameraLensDirection.back:
          return x * canvasSize.width / imageSize.width;
        default:
          return canvasSize.width - x * canvasSize.width / imageSize.width;
      }
  }
}

double translateY(
  double y,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      return y *
          canvasSize.height /
          (Platform.isIOS ? imageSize.height : imageSize.width);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      return y * canvasSize.height / imageSize.height;
  }
}

class FaceDetectorPainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;
  final String name;
  final String _detectionMessage;

  FaceDetectorPainter(
    this.faces,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
    this.name,
    this._detectionMessage,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..color = Colors.red;

          // Dibuja el mensaje de detección en la parte superior central del lienzo
    final ui.ParagraphBuilder messagePb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
    messagePb.pushStyle(ui.TextStyle(color: Colors.white, background: Paint()..color = Colors.black54));
    messagePb.addText(_detectionMessage);
    messagePb.pop();

    final ui.Paragraph messageParagraph = messagePb.build();
    messageParagraph.layout(ui.ParagraphConstraints(width: size.width));

    canvas.drawParagraph(
      messageParagraph,
      Offset(0, 20), // Posición en la parte superior con un pequeño margen
    );

    for (final Face face in faces) {
      final left = translateX(
        face.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        face.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        face.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        face.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint1);

      ui.ParagraphBuilder pb = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
      pb.pushStyle(ui.TextStyle(color: Colors.red));
      pb.addText(name);
      pb.pop();

      final paragraph = pb.build();
      // Use the full width from left to right of bounding box
      paragraph.layout(ui.ParagraphConstraints(width: face.boundingBox.width));

      // Calculate position above the rectangle
      final textOffset = Offset(
        // Align to the left edge of rectangle
        right,
        // Position above rectangle with 8px padding
        top - paragraph.height - 8,
      );

      canvas.drawParagraph(paragraph, textOffset);
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces || oldDelegate._detectionMessage != _detectionMessage;
  }
}
