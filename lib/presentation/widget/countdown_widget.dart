import 'package:flutter/material.dart';
import 'count_down.dart';

class EnhancedCountdownWidget extends StatefulWidget {
  final String message;
  final bool showCountdown;
  final double? progressValue;
  final Color? primaryColor;
  final Color? secondaryColor;
  final VoidCallback? onCountdownComplete;

  const EnhancedCountdownWidget({
    super.key,
    required this.message,
    required this.showCountdown,
    this.progressValue,
    this.primaryColor,
    this.secondaryColor,
    this.onCountdownComplete,
  });

  @override
  State<EnhancedCountdownWidget> createState() => _EnhancedCountdownWidgetState();
}

class _EnhancedCountdownWidgetState extends State<EnhancedCountdownWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // Controlador para el efecto de pulso
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Controlador para la escala de entrada
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Controlador para la rotación sutil
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    
    // Configurar animaciones
    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
    
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));
    
    // Iniciar animaciones
    _startAnimations();
  }

  void _startAnimations() {
    if (widget.showCountdown) {
      _scaleController.forward();
      _pulseController.repeat();
      _rotationController.repeat();
    } else {
      _pulseController.stop();
      _rotationController.stop();
      _scaleController.reverse();
    }
  }

  @override
  void didUpdateWidget(EnhancedCountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.showCountdown != widget.showCountdown) {
      _startAnimations();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _pulseAnimation,
        _scaleAnimation,
        _rotationAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value * 0.1, // Rotación muy sutil
            child: CustomPaint(
              painter: CountdownPainter(
                message: widget.message,
                showCountdown: widget.showCountdown,
                animationProgress: _scaleAnimation.value,
                pulseAnimation: _pulseAnimation.value,
                progressValue: widget.progressValue ?? 0.0,
                primaryColor: widget.primaryColor ?? Theme.of(context).primaryColor,
                secondaryColor: widget.secondaryColor ?? Theme.of(context).colorScheme.secondary,
              ),
              size: Size.infinite,
            ),
          ),
        );
      },
    );
  }
}
