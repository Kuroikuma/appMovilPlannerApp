import 'package:flutter/material.dart';

import '../../domain/entities.dart';

class TrabajadorCard extends StatelessWidget {
  final Trabajador trabajador;
  final VoidCallback? onTap;
  final Function(bool)? onChangeStatus;

  const TrabajadorCard({
    Key? key,
    required this.trabajador,
    this.onTap,
    this.onChangeStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              trabajador.faceSync
                  ? Colors.green.withOpacity(0.3)
                  : Colors.red.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar del trabajador
              _buildAvatar(),
              const SizedBox(width: 16),

              // Información del trabajador
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            trabajador.nombre,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // _buildStatusBadge(context),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${trabajador.primerApellido} ${trabajador.segundoApellido}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ID: ${trabajador.id}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Botones de acción
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon:
                        trabajador.faceSync
                            ? const Icon(Icons.face, color: Colors.green)
                            : const Icon(
                              Icons.face_retouching_off,
                              color: Colors.red,
                            ),
                    onPressed: onTap,
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
    return Hero(
      tag: 'trabajador-${trabajador.id}',
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[200],
        backgroundImage: null,
        child: Text(
          trabajador.nombre.isNotEmpty
              ? trabajador.nombre[0].toUpperCase()
              : '?',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: trabajador.faceSync ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: trabajador.faceSync ? Colors.green : Colors.red,
          width: 1,
        ),
      ),
      child: Text(
        trabajador.faceSync ? 'Activo' : 'Inactivo',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: trabajador.faceSync ? Colors.green[700] : Colors.red[700],
        ),
      ),
    );
  }
}
