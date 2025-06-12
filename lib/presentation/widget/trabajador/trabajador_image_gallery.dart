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
import '../../theme/app_colors.dart';
import '../../utils/facial_recognition_utils_dos.dart';
import 'existing_face_registration.dart';

class TrabajadorImageGallery extends ConsumerStatefulWidget {
  final Trabajador trabajador;
  final List<String> imagenes;

  const TrabajadorImageGallery({
    super.key,
    required this.trabajador,
    required this.imagenes,
  });

  @override
  ConsumerState<TrabajadorImageGallery> createState() => _TrabajadorImageGalleryState();
}

class _TrabajadorImageGalleryState extends ConsumerState<TrabajadorImageGallery> with TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  List<String> _imagenes = [];
  bool _isLoading = false;
  int _selectedImageIndex = -1;
  final _imagePicker = ImagePicker();

  bool _isDeleting = false;
  String? _deletingImageUrl;
  
  // Controladores de animación
  late AnimationController _deleteAnimationController;
  late AnimationController _scaleAnimationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _imagenes = widget.imagenes;
    
    // Añadir la foto de perfil al inicio de la galería si existe
    if (widget.trabajador.fotoUrl != "" && 
        !_imagenes.contains(widget.trabajador.fotoUrl)) {
      _imagenes.insert(0, widget.trabajador.fotoUrl);
    }

    // Inicializar controladores de animación
    _deleteAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _deleteAnimationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }

   Future<void> _deleteImage(int index, String imageUrl) async {
    // Verificar si es la foto de perfil
    final reconocimientoNotifier = ref.read(
      reconocimientoFacialNotifierProvider.notifier,
    );
    final bool isProfilePhoto = widget.trabajador.fotoUrl != "" && 
                               imageUrl == widget.trabajador.fotoUrl;
    
    if (isProfilePhoto) {
      _showErrorSnackBar('No se puede eliminar la foto de perfil');
      return;
    }

    // Mostrar diálogo de confirmación
    final bool? shouldDelete = await _showDeleteConfirmationDialog(imageUrl);
    
    if (shouldDelete == true) {
      try {
        setState(() {
          _isDeleting = true;
          _deletingImageUrl = imageUrl;
        });

        // Animar la eliminación
        await _scaleAnimationController.forward();
        
        // Simular eliminación del servidor
        
        await reconocimientoNotifier.deleteFace(widget.trabajador.id, imageUrl);
        // Eliminar de la lista local
        setState(() {
          _imagenes.removeAt(index);
          _isDeleting = false;
          _deletingImageUrl = null;
        });
        
        // Resetear animación
        _scaleAnimationController.reset();
        
        // Notificar al padre sobre las imágenes actualizadas
        _notifyImagesUpdated();
        
        // Mostrar mensaje de éxito
        _showSuccessSnackBar('Imagen eliminada exitosamente');
        
      } catch (e) {
        setState(() {
          _isDeleting = false;
          _deletingImageUrl = null;
        });
        _scaleAnimationController.reset();
        _showErrorSnackBar('Error al eliminar imagen: $e');
      }
    }
  }

    Future<bool?> _showDeleteConfirmationDialog(String imageUrl) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Eliminar Imagen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿Estás seguro de que deseas eliminar esta imagen?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.warning.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      color: AppColors.warning,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Esta acción no se puede deshacer.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
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
      },
    );
  }

  void _notifyImagesUpdated() {
    // Excluimos la foto de perfil si fue añadida al inicio
    final List<String> updatedImages = widget.trabajador.fotoUrl != "" && 
                                      _imagenes.isNotEmpty && 
                                      _imagenes[0] == widget.trabajador.fotoUrl
        ? _imagenes.sublist(1)
        : _imagenes;
        
    // widget.onImagesUpdated(updatedImages);
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _viewImage(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: Image.network(
                    _imagenes[index],
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / 
                                loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Botón de eliminar (solo si no es la foto de perfil)
                      if (!(widget.trabajador.fotoUrl != "" && 
                            _imagenes[index] == widget.trabajador.fotoUrl))
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _deleteImage(index, _imagenes[index]);
                            },
                          ),
                        ),
                      // Botón de cerrar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: index > 0
                        ? () {
                            Navigator.of(context).pop();
                            _viewImage(index - 1);
                          }
                        : null,
                  ),
                  Text('${index + 1} / ${_imagenes.length}'),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: index < _imagenes.length - 1
                        ? () {
                            Navigator.of(context).pop();
                            _viewImage(index + 1);
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                child: _imagenes.isEmpty
                    ? _buildEmptyState()
                    : _buildGalleryGrid(scrollController),
              ),
              _buildAddButton(),
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
          
          // Título y contador de imágenes
          Row(
            children: [
              Text(
                'Galería de Imágenes',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${_imagenes.length} ${_imagenes.length == 1 ? 'imagen' : 'imágenes'}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Información del trabajador
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: widget.trabajador.fotoUrl != "" 
                    ? NetworkImage(widget.trabajador.fotoUrl) 
                    : null,
                child: widget.trabajador.fotoUrl == "" 
                    ? Text(
                        widget.trabajador.nombre[0].toUpperCase(),
                        style: const TextStyle(fontSize: 14),
                      ) 
                    : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${widget.trabajador.primerApellido} ${widget.trabajador.segundoApellido} ${widget.trabajador.nombre}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryGrid(ScrollController scrollController) {
    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: _imagenes.length,
      itemBuilder: (context, index) {
        final String imageUrl = _imagenes[index];
        final bool isProfilePhoto = widget.trabajador.fotoUrl != "" && 
                                   imageUrl == widget.trabajador.fotoUrl;
        final bool isDeleting = _deletingImageUrl == imageUrl;

        return AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: isDeleting ? _scaleAnimation.value : 1.0,
              child: GestureDetector(
                onTap: () => _viewImage(index),
                child: Hero(
                  tag: 'image_${widget.trabajador.id}_$index',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / 
                                        loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                          
                          // Overlay de eliminación
                          if (isDeleting)
                            Container(
                              color: Colors.black.withOpacity(0.7),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          
                          // Indicador para la foto de perfil
                          if (isProfilePhoto)
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          
                          // Botón de eliminar (solo si no es la foto de perfil)
                          if (!isProfilePhoto && !isDeleting)
                            Positioned(
                              top: 4,
                              left: 4,
                              child: GestureDetector(
                                onTap: () => _deleteImage(index, imageUrl),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

    Future<void> _registerFace(Trabajador trabajador) async {
    final reconocimientoNotifier = ref.read(
      reconocimientoFacialNotifierProvider.notifier,
    );
    final trabajadores = ref.read(trabajadorNotifierProvider).trabajadores;
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

      final name = await reconocimientoNotifier.identifyFace(embedding, false);
      // Update UI
      if (name != 'No Registrado') {
        if (name != trabajador.nombre) {

          await reconocimientoNotifier.setLoading(false);

          final Trabajador? existingWorker = trabajadores.cast<Trabajador?>().firstWhere(
            (t) => t?.nombre == name,
            orElse: () => null,
          );

          if (mounted) {
            await _showExistingFaceRegistrationDialog(existingWorker!);
            return;
 
          } else {
            return;
          }

        }
      }

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

  // Mostrar diálogo detallado cuando la cara ya está registrada
  Future<void> _showExistingFaceRegistrationDialog(Trabajador existingWorker) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ExistingFaceRegistrationWidget(
            existingWorker: existingWorker,
            currentWorker: widget.trabajador,
            onViewProfile: () {
              Navigator.of(context).pop();
             
            },
            onContactSupport: () {
              Navigator.of(context).pop();
            },
            onCancel: () {
              Navigator.of(context).pop();
            },
            onForceRegister: () async {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
  

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No hay imágenes disponibles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Añade imágenes a la galería del trabajador',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _registerFace(widget.trabajador);
            },
            icon: const Icon(Icons.add_photo_alternate),
            label: const Text('Añadir Imagen'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: FilledButton.icon(
        onPressed: _isLoading ? null : () {
          Navigator.pop(context);
          _registerFace(widget.trabajador);
        },
        icon: _isLoading 
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.add_photo_alternate),
        label: Text(_isLoading ? 'Añadiendo...' : 'Añadir Imagen'),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
