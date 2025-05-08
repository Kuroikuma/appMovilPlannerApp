import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_colors.dart';

class LocationDeletionConfirmationModal extends ConsumerStatefulWidget {
  final String currentLocationName;
  final Function onConfirmDeletion;

  const LocationDeletionConfirmationModal({
    Key? key,
    required this.currentLocationName,
    required this.onConfirmDeletion,
  }) : super(key: key);

  @override
  ConsumerState<LocationDeletionConfirmationModal> createState() =>
      _LocationDeletionConfirmationModalState();
}

class _LocationDeletionConfirmationModalState
    extends ConsumerState<LocationDeletionConfirmationModal> {
  final TextEditingController _verificationCodeController =
      TextEditingController();
  bool _isVerificationCodeValid = false;
  String? _errorMessage;

  @override
  void dispose() {
    _verificationCodeController.dispose();
    super.dispose();
  }

  void _validateVerificationCode(String value) {
    setState(() {
      _isVerificationCodeValid = value.trim().isNotEmpty;
      _errorMessage = _isVerificationCodeValid ? null : 'Código de verificación requerido';
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Indicador de arrastre
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: colorScheme.onSurface.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      
                      // Ícono de advertencia
                      Center(
                        child: Container(
                          width: 64,
                          height: 64,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.warningLight,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.warning_rounded,
                            size: 32,
                            color: AppColors.warning,
                          ),
                        ),
                      ),
                      
                      // Título y subtítulo
                      Center(
                        child: Text(
                          'Eliminar ubicación',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Estás a punto de eliminar la ubicación',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          '"${widget.currentLocationName}"',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Explicación detallada
                      _buildInfoSection(
                        icon: Icons.info_outline,
                        title: '¿Qué significa esto?',
                        content: 'Al eliminar esta ubicación, se desvinculará completamente de este dispositivo. No podrás registrar asistencia ni acceder a la información asociada a esta ubicación.',
                        backgroundColor: AppColors.infoLight,
                        iconColor: AppColors.info,
                      ),
                      const SizedBox(height: 16),
                      
                      _buildInfoSection(
                        icon: Icons.next_plan_outlined,
                        title: 'Próximos pasos',
                        content: 'Después de eliminar esta ubicación, podrás verificar una nueva ubicación utilizando otro código QR o código de verificación. Esto te permitirá configurar el dispositivo para una ubicación diferente.',
                        backgroundColor: AppColors.primaryLight,
                        iconColor: AppColors.primary,
                      ),
                      const SizedBox(height: 24),
                      
                      // Campo de código de verificación
                      Text(
                        'Código de verificación',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Para confirmar la eliminación, ingresa el código de verificación asociado a esta ubicación:',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildVerificationCodeField(colorScheme),
                      const SizedBox(height: 32),
                      
                      // Botones de acción
                      _buildActionButtons(colorScheme),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

Widget _buildInfoSection({
  required IconData icon,
  required String title,
  required String content,
  required Color backgroundColor,
  required Color iconColor,
}) {
  final theme = Theme.of(context);

  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.grey[300]!),
    ),
    color: backgroundColor,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildVerificationCodeField(ColorScheme colorScheme) {
    return TextField(
      controller: _verificationCodeController,
      decoration: InputDecoration(
        hintText: 'Ingresa el código de verificación',
        errorText: _errorMessage,
        prefixIcon: Icon(
          Icons.vpn_key_outlined,
          color: colorScheme.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      style: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 16,
      ),
      onChanged: _validateVerificationCode,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildActionButtons(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: colorScheme.outline),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _isVerificationCodeValid
                ? () {
                    widget.onConfirmDeletion(_verificationCodeController.text);
                    Navigator.of(context).pop();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: AppColors.error.withOpacity(0.5),
              disabledForegroundColor: Colors.white.withOpacity(0.7),
            ),
            child: const Text(
              'Eliminar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
