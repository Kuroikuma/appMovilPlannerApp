import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities.dart';
import '../../providers/use_case/reconocimiento_facial.dart';
import '../../theme/app_colors.dart';

class ExistingFaceRegistrationWidget extends ConsumerStatefulWidget {
  final VoidCallback onViewProfile;
  final VoidCallback onContactSupport;
  final VoidCallback onCancel;
  final VoidCallback onForceRegister;

  const ExistingFaceRegistrationWidget({
    super.key,
    required this.onViewProfile,
    required this.onContactSupport,
    required this.onCancel,
    required this.onForceRegister,
  });

  @override
  ConsumerState<ExistingFaceRegistrationWidget> createState() =>
      _ExistingFaceRegistrationWidgetState();
}

class _ExistingFaceRegistrationWidgetState
    extends ConsumerState<ExistingFaceRegistrationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  bool _showAdvancedOptions = false;

  @override
  void initState() {
    super.initState();

    // Configurar animaciones
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // Iniciar animación
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reconocimientoFacialState = ref.watch(
      reconocimientoFacialNotifierProvider,
    );

    final currentWorker = reconocimientoFacialState.trabajadorBiometricoActual;
    final existingWorker = reconocimientoFacialState.trabajadorIdentificado;

    if (currentWorker == null || existingWorker == null) {
      print('currentWorker: $currentWorker');
      print('existingWorker: $existingWorker');
      return const SizedBox.shrink();
    }

    return FadeTransition(
      opacity: _fadeInAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildConflictExplanation(currentWorker!),
                const SizedBox(height: 24),
                _buildExistingWorkerInfo(existingWorker!),
                const SizedBox(height: 24),
                _buildActionButtons(),
                if (_showAdvancedOptions) ...[
                  const SizedBox(height: 16),
                  _buildAdvancedOptions(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.face_retouching_natural,
            color: AppColors.warning,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Conflicto de Registro Facial',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Esta cara ya está registrada',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConflictExplanation(Trabajador currentWorker) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.info, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Información del Conflicto',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'La cara que intentas registrar para "${currentWorker.nombreCompleto}" '
            'ya está asociada con otro trabajador en el sistema. '
            'Esto puede deberse a un registro previo o a una coincidencia facial.',
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildExistingWorkerInfo(Trabajador existingWorker) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trabajador con Registro Existente',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto del trabajador
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                child:
                    existingWorker.fotoUrl != ""
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            existingWorker.fotoUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                          ),
                        )
                        : Center(
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey[400],
                          ),
                        ),
              ),
              const SizedBox(width: 16),
              // Información del trabajador
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      existingWorker.nombreCompleto,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      Icons.badge_outlined,
                      'ID: ${existingWorker.id}',
                    ),
                    const SizedBox(height: 4),
                    _buildInfoRow(Icons.work_outline, existingWorker.cargo),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Estado del trabajador
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color:
                  existingWorker.estado
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  existingWorker.estado
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  size: 16,
                  color:
                      existingWorker.estado
                          ? AppColors.success
                          : AppColors.error,
                ),
                const SizedBox(width: 6),
                Text(
                  existingWorker.estado ? 'Activo' : 'Inactivo',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        existingWorker.estado
                            ? AppColors.success
                            : AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: widget.onViewProfile,
          icon: const Icon(Icons.person_search),
          label: const Text('Ver Perfil del Trabajador'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: widget.onContactSupport,
          icon: const Icon(Icons.support_agent),
          label: const Text('Contactar Soporte'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            setState(() {
              _showAdvancedOptions = !_showAdvancedOptions;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _showAdvancedOptions
                    ? 'Ocultar Opciones Avanzadas'
                    : 'Mostrar Opciones Avanzadas',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 4),
              Icon(
                _showAdvancedOptions
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextButton(onPressed: widget.onCancel, child: const Text('Cancelar')),
      ],
    );
  }

  Widget _buildAdvancedOptions() {
    return AnimatedOpacity(
      opacity: _showAdvancedOptions ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.warning.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.warning.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber_outlined,
                  color: AppColors.warning,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Opciones Administrativas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Las siguientes opciones requieren privilegios administrativos y pueden afectar '
              'el funcionamiento del sistema de reconocimiento facial.',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: widget.onForceRegister,
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Transferir Registro Facial'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.warning,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Esta acción transferirá el registro facial del trabajador actual al nuevo trabajador. '
              'El trabajador anterior ya no será reconocido con esta cara.',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
