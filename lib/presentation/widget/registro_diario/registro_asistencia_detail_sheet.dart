import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/registro_diario.dart';
import '../../theme/app_colors.dart';

class RegistroAsistenciaDetailSheet extends StatelessWidget {
  final RegistroDiario registro;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final Function(bool)? onStatusChanged;
  final VoidCallback? onRegistrarSalida;

  const RegistroAsistenciaDetailSheet({
    Key? key,
    required this.registro,
    this.onEditPressed,
    this.onDeletePressed,
    this.onStatusChanged,
    this.onRegistrarSalida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildRegistroInfoSection(context),
                    const Divider(height: 32),
                    _buildTrabajadorInfoSection(context),
                    const Divider(height: 32),
                    if (!registro.tieneSalida && onRegistrarSalida != null)
                      _buildRegistrarSalidaSection(context),
                    if (!registro.tieneSalida && onRegistrarSalida != null)
                      const Divider(height: 32),
                    _buildActionsSection(context),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Indicador de arrastre
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Título y estado del registro
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: registro.tieneSalida
                      ? AppColors.successLight
                      : AppColors.infoLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  registro.tieneSalida
                      ? Icons.check_circle
                      : Icons.access_time,
                  color: registro.tieneSalida
                      ? AppColors.success
                      : AppColors.info,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registro de Asistencia',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: registro.estado
                                ? AppColors.successLight
                                : AppColors.errorLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                registro.estado
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                size: 14,
                                color: registro.estado
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                registro.estado ? 'Activo' : 'Inactivo',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: registro.estado
                                      ? AppColors.success
                                      : AppColors.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: registro.tieneSalida
                                ? AppColors.successLight
                                : AppColors.warningLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                registro.tieneSalida
                                    ? Icons.done_all
                                    : Icons.schedule,
                                size: 14,
                                color: registro.tieneSalida
                                    ? AppColors.success
                                    : AppColors.warning,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                registro.tieneSalida
                                    ? 'Completo'
                                    : 'En curso',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: registro.tieneSalida
                                      ? AppColors.success
                                      : AppColors.warning,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegistroInfoSection(BuildContext context) {
    // Formatear fecha y hora
    final fechaIngreso = DateFormat('EEEE, d MMMM yyyy', 'es').format(registro.fechaIngreso);
    final horaIngreso = '${registro.horaIngreso.hour.toString().padLeft(2, '0')}:${registro.horaIngreso.minute.toString().padLeft(2, '0')}';
    
    String? fechaSalida;
    String? horaSalida;
    
    if (registro.tieneSalida) {
      fechaSalida = DateFormat('EEEE, d MMMM yyyy', 'es').format(registro.fechaSalida!);
      horaSalida = '${registro.horaSalida!.hour.toString().padLeft(2, '0')}:${registro.horaSalida!.minute.toString().padLeft(2, '0')}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildSectionTitle(context, 'Detalles del Registro'),
        const SizedBox(height: 16),
        
        _buildInfoItem(
          context,
          icon: Icons.numbers,
          title: 'ID del Registro',
          value: registro.id?.toString() ?? 'No asignado',
        ),
        
        _buildInfoItem(
          context,
          icon: Icons.login,
          title: 'Entrada',
          value: '$fechaIngreso a las $horaIngreso',
        ),
        
        if (registro.tieneSalida)
          _buildInfoItem(
            context,
            icon: Icons.logout,
            title: 'Salida',
            value: '$fechaSalida a las $horaSalida',
          ),
        
        if (registro.tieneSalida)
          _buildInfoItem(
            context,
            icon: Icons.timelapse,
            title: 'Duración',
            value: registro.duracionFormateada,
          ),
        
        if (!registro.tieneSalida && registro.tiempoTranscurridoDesdeIngreso.inMinutes > 0)
          _buildInfoItem(
            context,
            icon: Icons.timelapse,
            title: 'Tiempo Transcurrido',
            value: _formatDuration(registro.tiempoTranscurridoDesdeIngreso),
          ),
        
        if (registro.reconocimientoFacialId != null)
          _buildInfoItem(
            context,
            icon: Icons.face,
            title: 'ID Biométrico',
            value: registro.reconocimientoFacialId!,
          ),
      ],
    );
  }

  Widget _buildTrabajadorInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Información del Trabajador'),
        const SizedBox(height: 16),
        
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: registro.fotoTrabajador != null 
                  ? NetworkImage(registro.fotoTrabajador!) 
                  : null,
              child: registro.fotoTrabajador == null 
                  ? Text(
                      registro.nombreTrabajador![0].toUpperCase(),
                      style: const TextStyle(fontSize: 20),
                    ) 
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    registro.nombreTrabajador!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (registro.cargoTrabajador != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      registro.cargoTrabajador!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    'ID: ${registro.equipoId}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegistrarSalidaSection(BuildContext context) {
    final puedeRegistrar = registro.puedeRegistrarSalida;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Registrar Salida'),
        const SizedBox(height: 16),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: puedeRegistrar 
                ? AppColors.infoLight 
                : AppColors.warningLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: puedeRegistrar 
                  ? AppColors.info.withOpacity(0.3) 
                  : AppColors.warning.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    puedeRegistrar 
                        ? Icons.info_outline 
                        : Icons.access_time,
                    color: puedeRegistrar 
                        ? AppColors.info 
                        : AppColors.warning,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    puedeRegistrar 
                        ? 'Puede registrar salida' 
                        : 'Tiempo mínimo no cumplido',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: puedeRegistrar 
                          ? AppColors.info 
                          : AppColors.warning,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                puedeRegistrar 
                    ? 'El trabajador puede registrar su salida ahora.' 
                    : 'Debe esperar ${registro.tiempoRestanteFormateado} antes de poder registrar la salida.',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: puedeRegistrar ? onRegistrarSalida : null,
                  icon: const Icon(Icons.logout),
                  label: const Text('Registrar Salida'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Acciones'),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onEditPressed,
                icon: const Icon(Icons.edit),
                label: const Text('Editar'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: onStatusChanged != null 
                    ? () => onStatusChanged!(!registro.estado) 
                    : null,
                icon: Icon(
                  registro.estado ? Icons.cancel : Icons.check_circle,
                ),
                label: Text(
                  registro.estado ? 'Desactivar' : 'Activar',
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: registro.estado 
                      ? AppColors.warning 
                      : AppColors.success,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete, color: AppColors.error),
            label: const Text('Eliminar Registro'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    bool isLink = false,
    VoidCallback? onTap,
  }) {
    final textWidget = Text(
      value,
      style: TextStyle(
        fontSize: 16,
        color: isLink ? Theme.of(context).colorScheme.primary : null,
        decoration: isLink ? TextDecoration.underline : null,
      ),
    );
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                isLink && onTap != null
                    ? GestureDetector(
                        onTap: onTap,
                        child: textWidget,
                      )
                    : textWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '$hours h $minutes min';
    } else {
      return '$minutes minutos';
    }
  }
}
