import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../loading_overlay.dart';
import 'dart:async';

class LoadingOverlayExistingFace extends StatefulWidget {
  const LoadingOverlayExistingFace({super.key});

  @override
  State<LoadingOverlayExistingFace> createState() =>
      _LoadingOverlayExistingFaceState();
}

class _LoadingOverlayExistingFaceState
    extends State<LoadingOverlayExistingFace> {
  bool _isLoading = false;
  bool _useLinearProgress = false;
  bool _showCancelButton = false;
  double? _progressValue;
  String _loadingMessage = 'Cargando...';
  final LoadingOverlayController _controller = LoadingOverlayController();
  Timer? _progressTimer;

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  void _startLoading() {
    setState(() {
      _isLoading = true;
      _progressValue = _useLinearProgress ? 0.0 : null;
    });

    if (_useLinearProgress) {
      _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (
        timer,
      ) {
        if (_progressValue != null && _progressValue! < 1.0) {
          setState(() {
            _progressValue = _progressValue! + 0.01;
          });
        } else {
          timer.cancel();
          setState(() {
            _isLoading = false;
          });
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  void _startControlledLoading() {
    _controller.show(message: _loadingMessage);

    if (_useLinearProgress) {
      double progress = 0.0;
      _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (
        timer,
      ) {
        if (progress < 1.0) {
          progress += 0.01;
          _controller.updateProgress(progress);
        } else {
          timer.cancel();
          _controller.hide();
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        _controller.hide();
      });
    }
  }

  void _cancelLoading() {
    _progressTimer?.cancel();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Overlay Demo'),
        backgroundColor: AppColors.primary,
      ),
      body: ControlledLoadingOverlay(
        controller: _controller,
        useLinearProgress: _useLinearProgress,
        showCancelButton: _showCancelButton,
        onCancel: _cancelLoading,
        child: Stack(
          children: [
            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Configuración del LoadingOverlay',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Opciones de configuración
                  SwitchListTile(
                    title: const Text('Usar barra de progreso lineal'),
                    value: _useLinearProgress,
                    onChanged: (value) {
                      setState(() {
                        _useLinearProgress = value;
                      });
                    },
                  ),

                  SwitchListTile(
                    title: const Text('Mostrar botón de cancelar'),
                    value: _showCancelButton,
                    onChanged: (value) {
                      setState(() {
                        _showCancelButton = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Mensaje de carga',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _loadingMessage = value;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  // Botones de demostración
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _startLoading,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Mostrar Overlay Básico'),
                      ),

                      ElevatedButton(
                        onPressed: _startControlledLoading,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Usar Controlador'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Ejemplos de uso
                  const Text(
                    'Ejemplos de uso:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Uso básico:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'LoadingOverlay(\n'
                            '  message: "Cargando datos...",\n'
                            '  isLoading: true,\n'
                            ')',
                            style: TextStyle(fontFamily: 'monospace'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Con controlador:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'final controller = LoadingOverlayController();\n\n'
                            'ControlledLoadingOverlay(\n'
                            '  controller: controller,\n'
                            '  child: YourWidget(),\n'
                            ')',
                            style: TextStyle(fontFamily: 'monospace'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Overlay básico
            if (_isLoading)
              LoadingOverlay(
                message: _loadingMessage,
                useLinearProgress: _useLinearProgress,
                progressValue: _progressValue,
                showCancelButton: _showCancelButton,
                onCancel: _cancelLoading,
              ),
          ],
        ),
      ),
    );
  }
}
