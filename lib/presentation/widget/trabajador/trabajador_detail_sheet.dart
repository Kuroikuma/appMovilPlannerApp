import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities.dart';
import '../../theme/app_colors.dart';

class TrabajadorDetailSheet extends StatelessWidget {
  final Trabajador trabajador;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final Function(bool)? onStatusChanged;

  const TrabajadorDetailSheet({
    Key? key,
    required this.trabajador,
    this.onEditPressed,
    this.onDeletePressed,
    this.onStatusChanged,
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
                    _buildProfileSection(context),
                    const Divider(height: 32),
                    _buildWorkInfoSection(context),
                    // const Divider(height: 32),
                    // _buildContactSection(context),
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
          
          // Foto y nombre del trabajador
          Row(
            children: [
              Hero(
                tag: 'trabajador_${trabajador.id}',
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: trabajador.fotoUrl != null 
                      ? NetworkImage(trabajador.fotoUrl!) 
                      : null,
                  child: trabajador.fotoUrl == null 
                      ? Text(
                          trabajador.nombre[0].toUpperCase(),
                          style: const TextStyle(fontSize: 24),
                        ) 
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${trabajador.nombre} ${trabajador.primerApellido} ${trabajador.segundoApellido}",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                            color: trabajador.faceSync 
                                ? AppColors.successLight 
                                : AppColors.errorLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                trabajador.faceSync
                                    ? Icons.face
                                    : Icons.cancel,
                                size: 14,
                                color: trabajador.faceSync
                                    ? AppColors.success
                                    : AppColors.error,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                trabajador.faceSync ? 'Sincronizado' : 'No sincronizado',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: trabajador.faceSync
                                      ? AppColors.success
                                      : AppColors.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (trabajador.cargo != null)
                          Expanded(
                            child: Text(
                              trabajador.cargo!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildSectionTitle(context, 'Información Personal'),
        const SizedBox(height: 16),
        
        _buildInfoItem(
          context,
          icon: Icons.badge,
          title: 'ID',
          value: trabajador.id.toString()
        ),
        
        // if (trabajador.fechaIngreso != null)
        //   _buildInfoItem(
        //     context,
        //     icon: Icons.calendar_today,
        //     title: 'Fecha de Ingreso',
        //     value: DateFormat('dd/MM/yyyy').format(trabajador.fechaIngreso!),
        //   ),
        
          _buildInfoItem(
            context,
            icon: Icons.business,
            title: 'Cargo',
            value: trabajador.cargo,
          ),
      ],
    );
  }

  Widget _buildWorkInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Información Laboral'),
        const SizedBox(height: 16),
        
          _buildInfoItem(
            context,
            icon: Icons.work,
            title: 'Cargo',
            value: trabajador.cargo,
          ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Información de Contacto'),
        const SizedBox(height: 16),
        
          _buildInfoItem(
            context,
            icon: Icons.email,
            title: 'Email',
            value: "odio@gmail.com",
            isLink: true,
            onTap: () {
              // Implementar acción para abrir el email
            },
          ),
        
          _buildInfoItem(
            context,
            icon: Icons.phone,
            title: 'Teléfono',
            value: "123456789",
            isLink: true,
            onTap: () {
              // Implementar acción para llamar
            },
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
                    ? () => onStatusChanged!(!trabajador.faceSync) 
                    : null,
                icon: Icon(
                  trabajador.faceSync ? Icons.cancel : Icons.face,
                ),
                label: Text(
                  trabajador.faceSync ? 'Desactivar' : 'Activar',
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: trabajador.faceSync
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
            label: const Text('Eliminar Trabajador'),
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
}
