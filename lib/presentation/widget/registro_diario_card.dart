import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/registro_diario.dart';

class RegistroDiarioCard extends StatelessWidget {
  final RegistroDiario registro;
  final VoidCallback? onTap;
  final VoidCallback? onRegistrarSalida;
  final Function(bool)? onCambiarEstado;

  const RegistroDiarioCard({
    Key? key,
    required this.registro,
    this.onTap,
    this.onRegistrarSalida,
    this.onCambiarEstado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _getBorderColor(context), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado con información del trabajador
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar del trabajador
                  _buildAvatar(),
                  const SizedBox(width: 12),

                  // Información del trabajador
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          registro.nombreTrabajador ??
                              'Trabajador #${registro.equipoId}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (registro.cargoTrabajador != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            registro.cargoTrabajador!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Indicador de estado
                  _buildStatusBadge(context),
                ],
              ),

              const Divider(height: 24),

              // Detalles del registro
              Row(
                children: [
                  Expanded(
                    child: _buildInfoColumn(
                      context,
                      'Entrada',
                      _formatDate(registro.fechaIngreso),
                      _formatTime(registro.horaIngreso),
                      Icons.login,
                      Colors.blue,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  Expanded(
                    child:
                        registro.tieneSalida
                            ? _buildInfoColumn(
                              context,
                              'Salida',
                              _formatDate(registro.fechaSalida!),
                              _formatTime(registro.horaSalida!),
                              Icons.logout,
                              Colors.green,
                            )
                            : _buildRegistrarSalidaButton(context),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Duración y acciones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Duración
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Duración: ${registro.duracionFormateada}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // Acciones
                  if (onCambiarEstado != null)
                    Row(
                      children: [
                        Text(
                          registro.estado ? 'Activo' : 'Inactivo',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                registro.estado
                                    ? Colors.green[700]
                                    : Colors.red[700],
                          ),
                        ),
                        Switch(
                          value: registro.estado,
                          onChanged: onCambiarEstado,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.grey[200],
      backgroundImage:
          registro.fotoTrabajador != null
              ? NetworkImage(registro.fotoTrabajador!)
              : null,
      child:
          registro.fotoTrabajador == null
              ? Text(
                registro.nombreTrabajador != null &&
                        registro.nombreTrabajador!.isNotEmpty
                    ? registro.nombreTrabajador![0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              : null,
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final Color backgroundColor =
        registro.tieneSalida ? Colors.green[50]! : Colors.blue[50]!;
    final Color borderColor = registro.tieneSalida ? Colors.green : Colors.blue;
    final String text = registro.tieneSalida ? 'Completado' : 'En curso';
    final Color textColor =
        registro.tieneSalida ? Colors.green[700]! : Colors.blue[700]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInfoColumn(
    BuildContext context,
    String label,
    String date,
    String time,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          time,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrarSalidaButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Salida',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        OutlinedButton.icon(
          onPressed: onRegistrarSalida,
          icon: const Icon(Icons.logout, size: 16),
          label: const Text('Registrar salida'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            minimumSize: const Size(0, 36),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Color _getBorderColor(BuildContext context) {
    if (!registro.estado) {
      return Colors.red.withOpacity(0.3);
    }

    if (!registro.tieneSalida) {
      return Colors.blue.withOpacity(0.3);
    }

    return Colors.green.withOpacity(0.3);
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
