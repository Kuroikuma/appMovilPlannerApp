import 'package:flutter/material.dart';

import '../../screens/trabajador_screen.dart';

Widget buildProcesandoRegistroBiometrico(
  BuildContext context,
  AnimationController animationController,
) {
  final theme = Theme.of(context);

  return Container(
    color: theme.colorScheme.primary,
    child: SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.face_retouching_natural,
                  color: theme.colorScheme.onPrimary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  'Registro Biométrico',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated face scan indicator
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer circle
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.primary.withOpacity(0.2),
                              width: 8,
                            ),
                          ),
                        ),

                        // Animated progress circle
                        AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: LoadingArcPainter(
                                progress: animationController.value,
                                color: theme.colorScheme.primary,
                              ),
                              size: const Size(120, 120),
                            );
                          },
                        ),

                        // Face icon
                        Icon(
                          Icons.face,
                          size: 50,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Status text
                  Text(
                    'Registrando datos biométricos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Progress steps
                  _buildProgressStep(
                    icon: Icons.face_retouching_natural,
                    text: 'Analizando datos biométricos',
                    isActive: true,
                    context: context,
                  ),
                  _buildProgressStep(
                    icon: Icons.insights,
                    text: 'Procesando datos biométricos',
                    isActive: true,
                    context: context,
                  ),
                  _buildProgressStep(
                    icon: Icons.save,
                    text: 'Guardando datos biométricos',
                    isActive: false,
                    context: context,
                  ),

                  const SizedBox(height: 40),

                  // Tip text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Por favor, espere mientras guardamos sus datos biométricos para futuras verificaciones. Este proceso puede tomar unos segundos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onBackground.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildProgressStep({
  required IconData icon,
  required String text,
  required bool isActive,
  required BuildContext context,
}) {
  final theme = Theme.of(context);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                isActive
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color:
                isActive
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary.withOpacity(0.5),
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color:
                  isActive
                      ? theme.colorScheme.onBackground
                      : theme.colorScheme.onBackground.withOpacity(0.5),
            ),
          ),
        ),
        if (isActive)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: theme.colorScheme.primary,
            ),
          ),
      ],
    ),
  );
}
