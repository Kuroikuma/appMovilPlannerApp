import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CountdownPainter extends CustomPainter {
  final String message;
  final bool showCountdown;
  final double animationProgress; // 0.0 a 1.0 para animaciones
  final double pulseAnimation; // 0.0 a 1.0 para efecto de pulso
  final double progressValue; // 0.0 a 1.0 para la barra de progreso circular
  final Color primaryColor;
  final Color secondaryColor;

  CountdownPainter({
    required this.message,
    required this.showCountdown,
    this.animationProgress = 1.0,
    this.pulseAnimation = 0.0,
    this.progressValue = 0.0,
    this.primaryColor = AppColors.primary,
    this.secondaryColor = AppColors.primaryDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    if (showCountdown) {
      _drawCountdownElements(canvas, size, center);
    } else {
      _drawDetectionMessage(canvas, size, center);
    }
  }

  void _drawCountdownElements(Canvas canvas, Size size, Offset center) {
    // Calcular dimensiones basadas en el contenido
    final textPainter = _createTextPainter(
      message, 
      120, 
      FontWeight.w900, 
      Colors.white
    );
    textPainter.layout();
    
    final baseRadius = math.max(textPainter.width, textPainter.height) / 2 + 40;
    final animatedRadius = baseRadius * (0.8 + 0.2 * animationProgress);
    final pulseRadius = animatedRadius + (15 * pulseAnimation);

    // Dibujar fondo con gradiente radial
    _drawRadialGradientBackground(canvas, center, pulseRadius * 1.5);
    
    // Dibujar anillos de pulso
    _drawPulseRings(canvas, center, pulseRadius);
    
    // Dibujar círculo principal con gradiente
    _drawMainCircle(canvas, center, animatedRadius);
    
    // Dibujar barra de progreso circular
    _drawCircularProgress(canvas, center, animatedRadius + 20);
    
    // Dibujar efectos de brillo
    _drawGlowEffects(canvas, center, animatedRadius);
    
    // Dibujar el texto del countdown
    _drawCountdownText(canvas, center, textPainter);
    
    // Dibujar partículas decorativas
    _drawDecorativeParticles(canvas, center, animatedRadius);
  }

  void _drawDetectionMessage(Canvas canvas, Size size, Offset center) {
    // Fondo sutil para el mensaje de detección
    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: size.width * 0.8, height: 80),
      const Radius.circular(25),
    );
    
    canvas.drawRRect(backgroundRect, backgroundPaint);
    
    // Borde con gradiente
    final borderPaint = Paint()
      ..shader = LinearGradient(
        colors: [primaryColor.withOpacity(0.8), secondaryColor.withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(backgroundRect.outerRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    canvas.drawRRect(backgroundRect, borderPaint);
    
    // Texto del mensaje
    final textPainter = _createTextPainter(
      message, 
      18, 
      FontWeight.w600, 
      Colors.white
    );
    textPainter.layout();
    
    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    
    textPainter.paint(canvas, textOffset);
  }

  void _drawRadialGradientBackground(Canvas canvas, Offset center, double radius) {
    final gradientPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.0,
        colors: [
          primaryColor.withOpacity(0.1),
          primaryColor.withOpacity(0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    
    canvas.drawCircle(center, radius, gradientPaint);
  }

  void _drawPulseRings(Canvas canvas, Offset center, double baseRadius) {
    for (int i = 0; i < 3; i++) {
      final ringRadius = baseRadius + (i * 25) + (pulseAnimation * 10);
      final opacity = (1.0 - pulseAnimation) * (0.3 - i * 0.1);
      
      if (opacity > 0) {
        final ringPaint = Paint()
          ..color = secondaryColor.withOpacity(opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0 - (i * 0.5);
        
        canvas.drawCircle(center, ringRadius, ringPaint);
      }
    }
  }

  void _drawMainCircle(Canvas canvas, Offset center, double radius) {
    // Sombra del círculo
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    
    canvas.drawCircle(center.translate(0, 5), radius, shadowPaint);
    
    // Círculo principal con gradiente
    final circlePaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 1.2,
        colors: [
          Colors.black.withOpacity(0.9),
          Colors.black.withOpacity(0.7),
          Colors.black.withOpacity(0.8),
        ],
        stops: const [0.0, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius, circlePaint);
    
    // Borde exterior con gradiente
    final borderPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          primaryColor,
          secondaryColor,
          primaryColor.withOpacity(0.5),
          secondaryColor,
          primaryColor,
        ],
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        transform: GradientRotation(pulseAnimation * 2 * math.pi),
      ).createShader(Rect.fromCircle(center: center, radius: radius + 5))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    
    canvas.drawCircle(center, radius + 2, borderPaint);
  }

  void _drawCircularProgress(Canvas canvas, Offset center, double radius) {
    if (progressValue > 0) {
      // Fondo del progreso
      final backgroundProgressPaint = Paint()
        ..color = Colors.white.withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6.0
        ..strokeCap = StrokeCap.round;
      
      canvas.drawCircle(center, radius, backgroundProgressPaint);
      
      // Progreso activo
      final progressPaint = Paint()
        ..shader = SweepGradient(
          colors: [
            primaryColor,
            secondaryColor,
            primaryColor.withOpacity(0.8),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6.0
        ..strokeCap = StrokeCap.round;
      
      final progressPath = Path()
        ..addArc(
          Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2,
          2 * math.pi * progressValue,
        );
      
      canvas.drawPath(progressPath, progressPaint);
      
      // Punto final del progreso con glow
      if (progressValue > 0.05) {
        final endAngle = -math.pi / 2 + (2 * math.pi * progressValue);
        final endPoint = Offset(
          center.dx + radius * math.cos(endAngle),
          center.dy + radius * math.sin(endAngle),
        );
        
        final glowPaint = Paint()
          ..color = Colors.white
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
        
        canvas.drawCircle(endPoint, 8, glowPaint);
        
        final dotPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
        
        canvas.drawCircle(endPoint, 4, dotPaint);
      }
    }
  }

  void _drawGlowEffects(Canvas canvas, Offset center, double radius) {
    // Efecto de brillo interno
    final innerGlowPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.8,
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.7))
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius * 0.7, innerGlowPaint);
    
    // Highlight en la parte superior
    final highlightPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.5),
        radius: 0.5,
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.6))
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center.translate(0, -radius * 0.3), radius * 0.4, highlightPaint);
  }

  void _drawCountdownText(Canvas canvas, Offset center, TextPainter textPainter) {
    // Sombra del texto
    final shadowTextPainter = _createTextPainter(
      message, 
      120, 
      FontWeight.w900, 
      Colors.black.withOpacity(0.5)
    );
    shadowTextPainter.layout();
    
    final shadowOffset = Offset(
      center.dx - shadowTextPainter.width / 2 + 2,
      center.dy - shadowTextPainter.height / 2 + 2,
    );
    
    shadowTextPainter.paint(canvas, shadowOffset);
    
    // Texto principal con gradiente
    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    
    // Crear gradiente para el texto
    final textRect = Rect.fromLTWH(
      textOffset.dx, 
      textOffset.dy, 
      textPainter.width, 
      textPainter.height
    );
    
    final gradientTextPainter = _createGradientTextPainter(
      message, 
      120, 
      FontWeight.w900,
      textRect
    );
    gradientTextPainter.layout();
    gradientTextPainter.paint(canvas, textOffset);
  }

  void _drawDecorativeParticles(Canvas canvas, Offset center, double radius) {
    final particlePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;
    
    // Dibujar partículas decorativas alrededor del círculo
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi * 2 / 8) + (pulseAnimation * math.pi * 2);
      final particleRadius = radius + 40 + (math.sin(angle * 3) * 10);
      final particleSize = 3.0 + (math.sin(angle * 2 + pulseAnimation * math.pi * 2) * 2);
      
      final particlePosition = Offset(
        center.dx + particleRadius * math.cos(angle),
        center.dy + particleRadius * math.sin(angle),
      );
      
      canvas.drawCircle(particlePosition, particleSize, particlePaint);
    }
  }

  TextPainter _createTextPainter(String text, double fontSize, FontWeight fontWeight, Color color) {
    return TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: 2.0,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
  }

  TextPainter _createGradientTextPainter(String text, double fontSize, FontWeight fontWeight, Rect textRect) {
    return TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: 2.0,
          foreground: Paint()
            ..shader = LinearGradient(
              colors: [
                Colors.white,
                primaryColor.withOpacity(0.9),
                Colors.white,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(textRect),
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
  }

  @override
  bool shouldRepaint(CountdownPainter oldDelegate) {
    return oldDelegate.message != message ||
           oldDelegate.showCountdown != showCountdown ||
           oldDelegate.animationProgress != animationProgress ||
           oldDelegate.pulseAnimation != pulseAnimation ||
           oldDelegate.progressValue != progressValue ||
           oldDelegate.primaryColor != primaryColor ||
           oldDelegate.secondaryColor != secondaryColor;
  }
}
