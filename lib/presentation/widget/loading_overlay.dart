import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../theme/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  /// Mensaje que se muestra durante la carga
  final String message;

  /// Widget personalizado para mostrar como indicador (opcional)
  final Widget? loadingIndicator;

  /// Color de fondo del overlay
  final Color? backgroundColor;

  /// Color del texto del mensaje
  final Color? textColor;

  /// Color del indicador de progreso
  final Color? progressColor;

  /// Determina si el overlay está visible
  final bool isLoading;

  /// Opacidad del fondo del overlay (0.0 - 1.0)
  final double backgroundOpacity;

  /// Tamaño del indicador de carga
  final double indicatorSize;

  /// Tamaño del texto del mensaje
  final double fontSize;

  /// Peso de la fuente del mensaje
  final FontWeight fontWeight;

  /// Duración de la animación de entrada/salida
  final Duration animationDuration;

  /// Callback que se ejecuta cuando se completa la animación de salida
  final VoidCallback? onAnimationComplete;

  /// Determina si se debe mostrar un botón para cancelar la operación
  final bool showCancelButton;

  /// Callback que se ejecuta cuando se presiona el botón de cancelar
  final VoidCallback? onCancel;

  /// Texto para el botón de cancelar
  final String cancelButtonText;

  /// Determina si se debe mostrar un indicador de progreso lineal
  final bool useLinearProgress;

  /// Valor del progreso (0.0 - 1.0), null para progreso indeterminado
  final double? progressValue;

  const LoadingOverlay({
    Key? key,
    required this.message,
    this.loadingIndicator,
    this.backgroundColor,
    this.textColor,
    this.progressColor,
    this.isLoading = true,
    this.backgroundOpacity = 0.7,
    this.indicatorSize = 48.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onAnimationComplete,
    this.showCancelButton = false,
    this.onCancel,
    this.cancelButtonText = 'Cancelar',
    this.useLinearProgress = false,
    this.progressValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Si no está cargando, no mostramos nada
    if (!isLoading) {
      return const SizedBox.shrink();
    }

    // Construimos el indicador de carga apropiado
    Widget indicator;
    if (loadingIndicator != null) {
      indicator = loadingIndicator!;
    } else if (useLinearProgress) {
      indicator = SizedBox(
        width: 200,
        child: LinearProgressIndicator(
          value: progressValue,
          backgroundColor: AppColors.primary.withOpacity(0.2),
          color: progressColor ?? theme.colorScheme.primary,
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      );
    } else {
      indicator = SizedBox(
        height: indicatorSize,
        width: indicatorSize,
        child: CircularProgressIndicator(
          value: progressValue,
          strokeWidth: 4,
          color: progressColor ?? theme.colorScheme.primary,
          semanticsLabel: 'Indicador de carga',
        ),
      );
    }

    return AnimatedOpacity(
      opacity: isLoading ? 1.0 : 0.0,
      duration: animationDuration,
      onEnd: isLoading ? null : onAnimationComplete,
      child: Semantics(
        label: 'Pantalla de carga',
        value: message,
        button: showCancelButton,
        excludeSemantics: true,
        child: Stack(
          children: [
            // Barrera modal que bloquea interacciones
            ModalBarrier(
              dismissible: false,
              color: (backgroundColor ?? Colors.black).withOpacity(
                backgroundOpacity,
              ),
            ),
            // Contenido del overlay
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    indicator,
                    const SizedBox(height: 24),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: textColor ?? theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (showCancelButton) ...[
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: onCancel,
                        child: Text(
                          cancelButtonText,
                          style: TextStyle(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Controlador para gestionar el estado del LoadingOverlay
class LoadingOverlayController {
  bool _isLoading = false;
  String _message = 'Cargando...';
  double? _progress;

  /// Obtiene el estado actual de carga
  bool get isLoading => _isLoading;

  /// Obtiene el mensaje actual
  String get message => _message;

  /// Obtiene el valor actual del progreso
  double? get progress => _progress;

  /// Función para notificar cambios
  Function(bool isLoading, String message, double? progress)? onChanged;

  LoadingOverlayController({
    bool initialLoading = false,
    String initialMessage = 'Cargando...',
    double? initialProgress,
    this.onChanged,
  }) : _isLoading = initialLoading,
       _message = initialMessage,
       _progress = initialProgress;

  /// Muestra el overlay con el mensaje especificado
  void show({String? message, double? progress}) {
    _isLoading = true;
    if (message != null) _message = message;
    _progress = progress;
    onChanged?.call(_isLoading, _message, _progress);
  }

  /// Oculta el overlay
  void hide() {
    _isLoading = false;
    onChanged?.call(_isLoading, _message, _progress);
  }

  /// Actualiza el mensaje sin cambiar el estado de visibilidad
  void updateMessage(String message) {
    _message = message;
    onChanged?.call(_isLoading, _message, _progress);
  }

  /// Actualiza el progreso sin cambiar el estado de visibilidad
  void updateProgress(double? progress) {
    _progress = progress;
    onChanged?.call(_isLoading, _message, _progress);
  }
}

/// Widget que proporciona un LoadingOverlay gestionado por un controlador
class ControlledLoadingOverlay extends StatefulWidget {
  final Widget child;
  final LoadingOverlayController controller;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? progressColor;
  final bool useLinearProgress;
  final bool showCancelButton;
  final VoidCallback? onCancel;

  const ControlledLoadingOverlay({
    super.key,
    required this.child,
    required this.controller,
    this.backgroundColor,
    this.textColor,
    this.progressColor,
    this.useLinearProgress = false,
    this.showCancelButton = false,
    this.onCancel,
  });

  @override
  State<ControlledLoadingOverlay> createState() =>
      _ControlledLoadingOverlayState();
}

class _ControlledLoadingOverlayState extends State<ControlledLoadingOverlay> {
  late bool _isLoading;
  late String _message;
  late double? _progress;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.controller.isLoading;
    _message = widget.controller.message;
    _progress = widget.controller.progress;

    widget.controller.onChanged = (isLoading, message, progress) {
      if (mounted) {
        setState(() {
          _isLoading = isLoading;
          _message = message;
          _progress = progress;
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isLoading)
          LoadingOverlay(
            message: _message,
            isLoading: true,
            backgroundColor: widget.backgroundColor,
            textColor: widget.textColor,
            progressColor: widget.progressColor,
            useLinearProgress: widget.useLinearProgress,
            progressValue: _progress,
            showCancelButton: widget.showCancelButton,
            onCancel: widget.onCancel,
          ),
      ],
    );
  }
}
