import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/use_case/horario_notifier.dart';
import '../providers/use_case/reconocimiento_facial.dart';
import '../providers/use_case/registro_diario.dart';
import '../providers/use_case/trabajador.dart';
import '../providers/use_case/ubicacion.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../utils/notification_utils.dart';
import '../widget/location_deletion_overlay.dart';
import '../widget/ubicacion/location_deletion_confirmation_modal.dart';

class UbicacionScreen extends ConsumerStatefulWidget {
  const UbicacionScreen({super.key});

  @override
  ConsumerState<UbicacionScreen> createState() => _UbicacionScreenState();
}

class _UbicacionScreenState extends ConsumerState<UbicacionScreen> {
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    // Escuchar cambios en el estado de verificación para detectar cuando
    // la ubicación ha sido eliminada

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initHorarios();
      _initRegistrosDiarios();
      _cargarTrabajadores();
      _cargarRegistrosBiometricos();
    });

    ref.listenManual(ubicacionNotifierProvider, (previous, next) {
      // Si estamos eliminando y el estado de verificación cambia a false,
      // significa que la eliminación se completó
      if (_isDeleting && next.isVerify == false && !next.isLoading) {
        Navigator.of(
          context,
        ).pushReplacementNamed(AppRoutes.configurarUbicacion);
      }
    });
  }

  void _initHorarios() async {
    final ubicacionState = ref.read(ubicacionNotifierProvider);
    ref
        .read(horarioNotifierProvider.notifier)
        .cargarHorarios(ubicacionState.ubicacion!.ubicacionId.toString());
  }

  void _initRegistrosDiarios() async {
    final ubicacionState = ref.read(ubicacionNotifierProvider);
    ref
        .read(registroDiarioNotifierProvider.notifier)
        .cargarRegistros(
          ubicacionState.ubicacion!.ubicacionId.toString(),
          fecha: DateTime.now(),
        );
  }

  void _cargarTrabajadores() {
    final ubicacionState = ref.read(ubicacionNotifierProvider);
    if (ubicacionState.ubicacion != null &&
        ubicacionState.ubicacion!.ubicacionId != null) {
      ref
          .read(trabajadorNotifierProvider.notifier)
          .cargarTrabajadores(ubicacionState.ubicacion!.ubicacionId.toString());
    } else {
      NotificationUtils.showSnackBar(
        context: context,
        message: 'No se pudo obtener la ID de la ubicación',
        isError: true,
      );
    }
  }

  void _cargarRegistrosBiometricos() {
    ref
        .read(reconocimientoFacialNotifierProvider.notifier)
        .cargarRegistrosBiometricos();
  }

  void _showDeletionConfirmationModal() {
    final ubicacionState = ref.watch(ubicacionNotifierProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => LocationDeletionConfirmationModal(
            currentLocationName: ubicacionState.ubicacionNombre,
            onConfirmDeletion: (String verificationCode) {
              // Aquí puedes validar el código de verificación si es necesario
              _startDeletionProcess(verificationCode);
            },
          ),
    );
  }

  void _startDeletionProcess(String verificationCode) async {
    final notifier = ref.read(ubicacionNotifierProvider.notifier);
    final ubicacionState = ref.read(ubicacionNotifierProvider);

    setState(() {
      _isDeleting = true;
    });

    try {
      // Eliminar ubicación
      final success = await notifier.eliminarUbicacion(
        int.parse(verificationCode),
      );
      if (success) {
        // Navigator.of(context).pop();
      } else {
        setState(() {
          _isDeleting = false;
        });

        NotificationUtils.showSnackBar(
          context: context,
          message:
              ubicacionState.errorMessage ?? 'Error al eliminar la ubicación',
          icon: Icons.error,
          isError: true,
        );
      }
    } catch (e) {
      // Manejar error si es necesario
      if (mounted) {
        NotificationUtils.showSnackBar(
          context: context,
          message: 'Error al eliminar la ubicación: ${e.toString()}',
          isError: true,
        );

        // Ocultar pantalla de carga en caso de error
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ubicacionState = ref.watch(ubicacionNotifierProvider);
    final ubicacionNotifier = ref.read(ubicacionNotifierProvider.notifier);
    final ubicacion = ubicacionState.ubicacion!;

    final theme = Theme.of(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            AppColors.primary, // Cambia el color de fondo de la barra de estado
        statusBarIconBrightness:
            Brightness.light, // Iconos claros si el fondo es oscuro
      ),
    );

    return Scaffold(
      body:
          _isDeleting
              ? const LocationDeletionOverlay(isDeleting: true)
              : Center(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Encabezado con estado de verificación
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.verified_user,
                                color: Colors.green[700],
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green[700],
                                              size: 14,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Verificada',
                                              style: TextStyle(
                                                color: Colors.green[700],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    ubicacion.nombre ?? 'Sin nombre',
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Detalles de la ubicación
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detalles de la ubicación',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Información de la ubicación
                            _buildInfoCard(context, [
                                _buildInfoRow(
                                  context,
                                  'Ubicación ID',
                                  ubicacion.ubicacionId.toString(),
                                ),
                                _buildInfoRow(
                                  context,
                                  'Nombre',
                                  ubicacion.nombre,
                                ),

                                _buildInfoRow(
                                  context,
                                  'Código',
                                  ubicacion.codigoUbicacion.toString(),
                                ),
                            ]),

                            const SizedBox(height: 24),

                            // Sección "¿Qué puedes hacer ahora?"
                            Text(
                              '¿Qué puedes hacer ahora?',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Tarjetas de funcionalidades
                            _buildFunctionalityCards(context),

                            const SizedBox(height: 24),

                            // Botones de acción
                            _buildActionButtons(context, ubicacionNotifier),
                          ],
                        ),
                      ),
                      // Overlay de eliminación
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildInfoCard(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionalityCards(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Card(
            elevation: 0,
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withOpacity(0.7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.reconocimientoFacial);
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.face,
                        color: AppColors.primary,
                        size: 28, // Icono más grande
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Escanear asistencia',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Principal',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Registrar asistencia con reconocimiento facial',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // const SizedBox(height: 12),
        // _buildFeatureCard(
        //   context,
        //   icon: Icons.qr_code_scanner,
        //   title: 'Escanear asistencia',
        //   description:
        //       'Registra la asistencia de trabajadores mediante código QR',
        //   onTap: () {
        //     // Implementar funcionalidad de escaneo
        //     NotificationUtils.showSnackBar(
        //       context: context,
        //       message: 'Función de escaneo próximamente',
        //       isError: false,
        //       icon: Icons.qr_code_scanner,
        //     );
        //   },
        // ),
        const SizedBox(height: 12),
        _buildFeatureCard(
          context,
          icon: Icons.people,
          title: 'Ver trabajadores',
          description:
              'Accede a la lista de trabajadores asignados a esta ubicación',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.trabajadores);
          },
        ),
        const SizedBox(height: 12),
        _buildFeatureCard(
          context,
          icon: Icons.fact_check,
          title: 'Registro de asistencia',
          description:
              'Gestiona la asistencia de los trabajadores en esta ubicación',
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.registroAsistencia);
          },
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
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
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, UbicacionNotifier notifier) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              await notifier.verificarUbicacionConfiguradaLocal();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Verificar'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.tonalIcon(
            onPressed: () {
              _showDeletionConfirmationModal();
            },
            icon: const Icon(Icons.delete_outline),
            label: const Text('Eliminar'),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
