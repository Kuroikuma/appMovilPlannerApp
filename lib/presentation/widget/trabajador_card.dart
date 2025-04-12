import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entities.dart';
import '../providers/use_case/reconocimiento_facial.dart';

class TrabajadorCard extends ConsumerStatefulWidget {
  final Trabajador trabajador;
  final VoidCallback? onTap;
  final Function(bool)? onChangeStatus;

  const TrabajadorCard({
    super.key,
    required this.trabajador,
    this.onTap,
    this.onChangeStatus,
  });

  @override
  ConsumerState<TrabajadorCard> createState() => _TrabajadorCardState();
}

class _TrabajadorCardState extends ConsumerState<TrabajadorCard> {
  final _imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trabajador = widget.trabajador;
    final onTap = widget.onTap;

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
              _buildAvatar(trabajador),
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
                    onPressed: () => _registerFace(trabajador),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(Trabajador trabajador) {
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

  Widget _buildStatusBadge(BuildContext context, Trabajador trabajador) {
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
        trabajador.estado ? 'Activo' : 'Inactivo',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: trabajador.estado ? Colors.green[700] : Colors.red[700],
        ),
      ),
    );
  }

  Future<void> _registerFace(Trabajador trabajador) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final image = await _imagePicker.pickImage(source: ImageSource.camera);

      if (image == null) {
        return;
      }

      InputImage inputImage = InputImage.fromFile(File(image.path));
      final faces = await ref
          .read(reconocimientoFacialNotifierProvider.notifier)
          .detectFaces(inputImage);

      if (faces.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No face detected')));
        }
        return;
      }

      final input = ref
          .read(reconocimientoFacialNotifierProvider.notifier)
          .prepareInputFromImagePath({
            'imgPath': image.path,
            'face': faces.first,
          });
      final embedding = ref
          .read(reconocimientoFacialNotifierProvider.notifier)
          .getEmbedding(input);

      print('pasa del embending?');

      try {
        final imagenUrl =
            '$path/faces/${trabajador.id}-${trabajador.equipoId}.jpg';
        await ref
            .read(reconocimientoFacialNotifierProvider.notifier)
            .registerFace(trabajador.equipoId, embedding, image, imagenUrl);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error registering face: $e')));
        }
      }
    } finally {
      if (mounted) {}
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Face registered successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
