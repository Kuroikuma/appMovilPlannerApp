import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../domain/entities.dart';
import '../../providers/use_case/reconocimiento_facial.dart';
import '../../providers/use_case/trabajador.dart';
import '../../providers/use_case/ubicacion.dart';
import '../../utils/facial_recognition_utils_dos.dart';

class TrabajadorCard extends ConsumerStatefulWidget {
  final Trabajador trabajador;
  final Function(bool)? onChangeStatus;

  const TrabajadorCard({
    super.key,
    required this.trabajador,
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

    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar o iniciales
                CircleAvatar(
                  radius: 24,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                  backgroundImage:
                      trabajador.fotoUrl != ''
                          ? NetworkImage(trabajador.fotoUrl!)
                          : null,
                  child:
                      trabajador.fotoUrl == ''
                          ? Text(
                            trabajador.nombre[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              color: theme.colorScheme.primary,
                            ),
                          )
                          : null,
                ),

                const SizedBox(width: 16),

                // Información del trabajador
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${trabajador.primerApellido} ${trabajador.segundoApellido} ${trabajador.nombre}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        trabajador.cargo,
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        trabajador.identificacion,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Botón para tomar foto
            FilledButton.icon(
              onPressed: () {
                // Cerrar el DraggableScrollableSheet
                Navigator.of(context).pop();

                // Capturar imagen
                _registerFace(trabajador);
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Tomar Fotografía'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerFace(Trabajador trabajador) async {
    final reconocimientoNotifier = ref.read(
      reconocimientoFacialNotifierProvider.notifier,
    );
    final trabajadorNotifier = ref.read(trabajadorNotifierProvider.notifier);
    final ubicacionState = ref.read(ubicacionNotifierProvider);

    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;

      await reconocimientoNotifier.setLoading(true);

      final image = await _imagePicker.pickImage(source: ImageSource.camera);

      if (image == null) {
        await reconocimientoNotifier.setLoading(false);
        return;
      }

      await reconocimientoNotifier.setImagenFile(File(image.path));

      InputImage inputImage = InputImage.fromFile(File(image.path));
      final faces = await reconocimientoNotifier.detectFaces(inputImage);

      if (faces.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No face detected')));
        }
        await reconocimientoNotifier.setLoading(false);
        return;
      }

      final input = FacialRecognitionUtilsDos.prepareInputFromImagePath({
        'imgPath': image.path,
        'face': faces.first,
      });
      final embedding = reconocimientoNotifier.getEmbedding(input);

      try {
        final imagenUrl = '$path/${trabajador.id}-${trabajador.equipoId}.jpg';
        await reconocimientoNotifier.registerFace(
          trabajador.id,
          embedding,
          image,
          imagenUrl,
        );
        await trabajadorNotifier.cargarTrabajadores(ubicacionState.ubicacionId);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error registering face: $e')));
        }
      }
    } finally {
      if (mounted) {
        await reconocimientoNotifier.setLoading(false);
      }
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
