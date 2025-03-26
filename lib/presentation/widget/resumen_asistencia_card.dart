import 'package:flutter/material.dart';

import '../../domain/models/registro_diario.dart';

class ResumenAsistenciaCard extends StatelessWidget {
  final List<RegistroDiario> registros;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;

  const ResumenAsistenciaCard({
    Key? key,
    required this.registros,
    this.fechaInicio,
    this.fechaFin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Calcular estadísticas
    final totalRegistros = registros.length;
    final registrosCompletos = registros.where((r) => r.tieneSalida).length;
    final registrosPendientes = totalRegistros - registrosCompletos;

    // Calcular promedio de horas trabajadas
    Duration duracionTotal = Duration.zero;
    int registrosConDuracion = 0;

    for (final registro in registros) {
      if (registro.duracion != null) {
        duracionTotal += registro.duracion!;
        registrosConDuracion++;
      }
    }

    final promedioDuracion =
        registrosConDuracion > 0
            ? duracionTotal ~/ registrosConDuracion
            : Duration.zero;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Resumen de Asistencia',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // Período
            if (fechaInicio != null || fechaFin != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: theme.colorScheme.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Período: ${_formatPeriodo()}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

            // Estadísticas
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Total Registros',
                    totalRegistros.toString(),
                    Icons.list_alt,
                    theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Completos',
                    registrosCompletos.toString(),
                    Icons.check_circle_outline,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Pendientes',
                    registrosPendientes.toString(),
                    Icons.pending_actions,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Promedio de horas
            _buildStatCard(
              context,
              'Promedio de Horas Trabajadas',
              _formatDuration(promedioDuracion),
              Icons.access_time,
              theme.colorScheme.tertiary,
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color, {
    bool fullWidth = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment:
            fullWidth ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment:
                fullWidth ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 16),
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
            value,
            style: TextStyle(
              fontSize: fullWidth ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: fullWidth ? TextAlign.start : TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatPeriodo() {
    if (fechaInicio == null && fechaFin == null) {
      return 'Todos los registros';
    }

    if (fechaInicio != null && fechaFin == null) {
      return 'Desde ${_formatDate(fechaInicio!)}';
    }

    if (fechaInicio == null && fechaFin != null) {
      return 'Hasta ${_formatDate(fechaFin!)}';
    }

    return '${_formatDate(fechaInicio!)} - ${_formatDate(fechaFin!)}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    return '$hours h $minutes min';
  }
}
