import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities.dart';
import '../../../domain/models/registro_biometrico.dart';
import '../../providers/use_case/reconocimiento_facial.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../custom_app_bar.dart';
import '../loading_overlay.dart';

class ExistingFaceRegistrationScreen extends ConsumerStatefulWidget {
  final Trabajador existingWorker;
  final Trabajador currentWorker;
  final String registroBiometricoId;
  final List<RegistroBiometrico> registroBiometricos;

  const ExistingFaceRegistrationScreen({
    super.key,
    required this.existingWorker,
    required this.currentWorker,
    required this.registroBiometricoId,
    required this.registroBiometricos,
  });

  @override
  ConsumerState<ExistingFaceRegistrationScreen> createState() =>
      _ExistingFaceRegistrationScreenState();
}

class _ExistingFaceRegistrationScreenState
    extends ConsumerState<ExistingFaceRegistrationScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _showAdvancedOptions = false;
  String? _errorMessage;
  final LoadingOverlayController _controller = LoadingOverlayController();

  late TabController _tabController;
  final List<String> _tabs = ['Información', 'Opciones', 'Ayuda'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _viewWorkerProfile() async {
    setState(() => _isLoading = true);

    try {
      // Simular carga de datos
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      // Navegar al perfil del trabajador
      Navigator.of(context).pop('view_profile');
    } catch (e) {
      setState(() => _errorMessage = 'Error al cargar el perfil: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _contactSupport() async {
    setState(() => _isLoading = true);

    try {
      // Simular envío de reporte
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      // Mostrar confirmación y volver
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Solicitud enviada a soporte técnico'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop('contact_support');
    } catch (e) {
      setState(() => _errorMessage = 'Error al contactar soporte: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteRegistration() async {
    final reconocimientoNotifier = ref.read(
      reconocimientoFacialNotifierProvider.notifier,
    );

    final imageUrl =
        widget.registroBiometricos
            .firstWhere(
              (registro) => registro.id == widget.registroBiometricoId,
            )
            .blobFileString;

    // Mostrar diálogo de confirmación
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => _buildDeleteConfirmationDialog(),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);

    try {
      await reconocimientoNotifier.deleteFace(
        widget.existingWorker.id,
        imageUrl,
      );

      if (!mounted) return;

      // Mostrar confirmación y volver
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registro facial eliminado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pushNamed(AppRoutes.trabajadores);
    } catch (e) {
      setState(() => _errorMessage = 'Error en la eliminación: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildDeleteConfirmationDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.warning_amber_outlined,
              color: AppColors.error,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Confirmar Eliminación',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Estás seguro de que deseas eliminar el registro facial de ${widget.existingWorker.nombreCompleto}?',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.error.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.error, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Consecuencias de esta acción:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '• El registro facial será removido de ${widget.existingWorker.nombreCompleto}\n'
                  '• Esta acción puede requerir aprobación administrativa',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text(
            'Cancelar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.error,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text(
            'Eliminar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Conflicto de Registro Facial',
        showBackButton: true,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: ControlledLoadingOverlay(
        controller: _controller,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildInformationTab(),
                  _buildOptionsTab(),
                  _buildHelpTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.primary,
      child: TabBar(
        controller: _tabController,
        tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.7),
        indicatorColor: Colors.white,
        indicatorWeight: 3,
      ),
    );
  }

  Widget _buildInformationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_errorMessage != null) _buildErrorMessage(),
          _buildConflictExplanation(),
          const SizedBox(height: 24),
          _buildComparisonSection(),
          const SizedBox(height: 24),
          _buildExistingWorkerInfo(),
        ],
      ),
    );
  }

  Widget _buildOptionsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_errorMessage != null) _buildErrorMessage(),
          _buildActionCard(
            title: 'Ver Perfil Completo',
            description:
                'Accede a toda la información del trabajador con el registro facial existente.',
            icon: Icons.person_search,
            iconColor: AppColors.primary,
            onTap: _viewWorkerProfile,
          ),
          const SizedBox(height: 16),
          _buildActionCard(
            title: 'Contactar Soporte Técnico',
            description:
                'Solicita ayuda al equipo de soporte para resolver este conflicto de registro.',
            icon: Icons.support_agent,
            iconColor: AppColors.info,
            onTap: _contactSupport,
          ),
          const SizedBox(height: 16),
          _buildAdvancedOptionsCard(),
        ],
      ),
    );
  }

  Widget _buildHelpTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHelpSection(
            title: '¿Qué significa este conflicto?',
            content:
                'Un conflicto de registro facial ocurre cuando intentas registrar una cara que ya está asociada a otro trabajador en el sistema. Esto puede deberse a un registro previo o a una coincidencia facial significativa.',
            icon: Icons.help_outline,
          ),
          const SizedBox(height: 16),
          _buildHelpSection(
            title: '¿Qué opciones tengo?',
            content:
                'Puedes ver el perfil del trabajador existente para verificar su identidad, contactar al soporte técnico para resolver el conflicto, o si tienes permisos administrativos, eliminar el registro facial al trabajador existente.',
            icon: Icons.list_alt,
          ),
          const SizedBox(height: 16),
          _buildHelpSection(
            title: '¿Qué ocurre si elimino el registro?',
            content:
                'Al eliminar el registro facial, el trabajador ya no será reconocido con esta cara. Esta acción puede requerir aprobación administrativa y afecta directamente al sistema de reconocimiento facial.',
            icon: Icons.delete_forever_outlined,
          ),
          const SizedBox(height: 16),
          _buildHelpSection(
            title: 'Contacto de soporte',
            content:
                'Email: soporte@empresa.com\nTeléfono: +1 (555) 123-4567\nHorario: Lunes a Viernes, 8:00 AM - 6:00 PM',
            icon: Icons.contact_support,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: TextStyle(color: AppColors.error),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            onPressed: () => setState(() => _errorMessage = null),
            color: AppColors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildConflictExplanation() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                const Expanded(
                  child: Text(
                    'Conflicto Detectado',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'ID del Registro Biométrico: ',
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
            Text(
              widget.registroBiometricoId,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'El rostro que intentas registrar para "${widget.currentWorker.nombreCompleto}" '
              'ya está asociada con otro trabajador en el sistema. '
              'Esto puede deberse a un registro previo o a una coincidencia facial.',
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comparación de Trabajadores',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildWorkerComparisonCard(
                    widget.currentWorker,
                    'Trabajador Actual',
                    AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildWorkerComparisonCard(
                    widget.existingWorker,
                    'Trabajador con Registro',
                    AppColors.warning,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerComparisonCard(
    Trabajador worker,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 12),
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                worker.fotoUrl.isNotEmpty ? NetworkImage(worker.fotoUrl) : null,
            child:
                worker.fotoUrl.isEmpty
                    ? Text(
                      worker.nombre[0].toUpperCase(),
                      style: const TextStyle(fontSize: 30),
                    )
                    : null,
          ),
          const SizedBox(height: 12),
          Text(
            worker.nombreCompleto,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            worker.cargo,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color:
                  worker.estado
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              worker.estado ? 'Activo' : 'Inactivo',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: worker.estado ? AppColors.success : AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExistingWorkerInfo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información Detallada',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('ID', widget.existingWorker.id.toString()),
            const Divider(),
            _buildInfoRow(
              'Nombre Completo',
              widget.existingWorker.nombreCompleto,
            ),
            const Divider(),
            _buildInfoRow('Cargo', widget.existingWorker.cargo),
            const Divider(),
            _buildInfoRow(
              'Estado',
              widget.existingWorker.estado ? 'Activo' : 'Inactivo',
              valueColor:
                  widget.existingWorker.estado
                      ? AppColors.success
                      : AppColors.error,
            ),
            const Divider(),
            _buildInfoRow(
              'Fecha de Registro',
              '01/01/2023', // Simulado
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                color: valueColor ?? Colors.black87,
                fontWeight: valueColor != null ? FontWeight.bold : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdvancedOptionsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.admin_panel_settings,
                    color: AppColors.warning,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Opciones Administrativas',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _showAdvancedOptions
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      _showAdvancedOptions = !_showAdvancedOptions;
                    });
                  },
                ),
              ],
            ),
            if (_showAdvancedOptions) ...[
              const SizedBox(height: 16),
              const Text(
                'Las siguientes opciones requieren privilegios administrativos y pueden afectar '
                'el funcionamiento del sistema de reconocimiento facial.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _deleteRegistration,
                icon: const Icon(Icons.delete),
                label: const Text('Eliminar Registro Facial'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.error,
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Esta acción eliminará el registro facial del trabajador ${widget.existingWorker.nombreCompleto}. '
                'El trabajador ya no será reconocido con esta cara.',
                style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHelpSection({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.info),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Cancelar'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: _contactSupport,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Contactar Soporte'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
