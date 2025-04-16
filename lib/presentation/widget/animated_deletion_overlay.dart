import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedDeletionOverlay extends StatefulWidget {
  final bool isDeleting;

  const AnimatedDeletionOverlay({Key? key, required this.isDeleting})
    : super(key: key);

  @override
  State<AnimatedDeletionOverlay> createState() =>
      _AnimatedDeletionOverlayState();
}

class _AnimatedDeletionOverlayState extends State<AnimatedDeletionOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.7, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.7), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isDeleting) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: size.width,
        height: size.height,
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
                      Icons.delete_outline,
                      color: theme.colorScheme.onPrimary,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Eliminando Ubicación',
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),

                          // Animated icon
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Transform.rotate(
                                  angle: _rotationAnimation.value,
                                  child: Opacity(
                                    opacity: _opacityAnimation.value,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary
                                            .withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.location_off,
                                          size: 50,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 40),

                          // Status text
                          Text(
                            'Eliminando ubicación...',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 16),

                          // Subtitle
                          Text(
                            'Por favor espere mientras se completa el proceso',
                            style: TextStyle(
                              fontSize: 16,
                              color: theme.colorScheme.onBackground.withOpacity(
                                0.7,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 40),

                          // Progress indicator
                          Container(
                            width: size.width * 0.7,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: LinearProgressIndicator(
                              backgroundColor: theme.colorScheme.primary
                                  .withOpacity(0.2),
                              color: theme.colorScheme.primary,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),

                          const SizedBox(height: 60),

                          // Process steps
                          _buildProcessStep(
                            context,
                            icon: Icons.delete_sweep,
                            title: 'Eliminando datos de ubicación',
                            isActive: true,
                          ),

                          _buildProcessStep(
                            context,
                            icon: Icons.link_off,
                            title: 'Desvinculando recursos asociados',
                            isActive: true,
                          ),

                          _buildProcessStep(
                            context,
                            icon: Icons.settings_backup_restore,
                            title: 'Restaurando configuración inicial',
                            isActive: false,
                          ),

                          const SizedBox(height: 60),

                          // Information card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: theme.colorScheme.primary.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: theme.colorScheme.primary,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '¿Qué sucede después?',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Key information about reconfiguring
                                _buildInfoItem(
                                  context,
                                  icon: Icons.add_location_alt,
                                  text:
                                      'Podrá configurar una nueva ubicación una vez completado el proceso.',
                                  isHighlighted: true,
                                ),
                                const SizedBox(height: 12),

                                // Additional context
                                _buildInfoItem(
                                  context,
                                  icon: Icons.delete_sweep,
                                  text:
                                      'Se eliminarán todos los datos asociados a esta ubicación.',
                                ),
                                const SizedBox(height: 12),

                                // Guidance
                                _buildInfoItem(
                                  context,
                                  icon: Icons.settings_backup_restore,
                                  text:
                                      'Este proceso no puede revertirse una vez completado.',
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Additional note
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.amber[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.amber[300]!),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.amber[800],
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'La aplicación le redirigirá automáticamente cuando el proceso finalice.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.amber[900],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcessStep(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isActive,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
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
              title,
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
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    bool isHighlighted = false,
  }) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                isHighlighted
                    ? theme.colorScheme.primary.withOpacity(0.2)
                    : theme.colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  isHighlighted
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: Icon(
            icon,
            size: 20,
            color:
                isHighlighted
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              color: theme.colorScheme.onSurface.withOpacity(
                isHighlighted ? 1.0 : 0.9,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
