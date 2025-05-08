import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/network/network_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../providers/use_case/ubicacion.dart';
import '../routes/app_routes.dart';
import '../utils/notification_utils.dart';

class ConfiurarUbicacionFormScreen extends ConsumerStatefulWidget {
  const ConfiurarUbicacionFormScreen({super.key});

  @override
  ConsumerState<ConfiurarUbicacionFormScreen> createState() =>
      _ConfiurarUbicacionFormScreenState();
}

class _ConfiurarUbicacionFormScreenState
    extends ConsumerState<ConfiurarUbicacionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codigoUbicacionController;
  bool _isSubmitting = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _codigoUbicacionController = TextEditingController();
  }

  @override
  void dispose() {
    _codigoUbicacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ubicacionState = ref.watch(ubicacionNotifierProvider);

    // Mostrar notificación si hay error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ubicacionState.errorType != null && mounted) {
        if (ubicacionState.errorType == UbicacionErrorType.noInternet) {
          NotificationUtils.showNoInternetNotification(context);
        } else {
          NotificationUtils.showSnackBar(
            context: context,
            message:
                ubicacionState.errorMessage ?? 'Error al configurar ubicación',
            isError: true,
          );
        }
        // Limpiar el error después de mostrarlo
        ref.read(ubicacionNotifierProvider.notifier).clearErrors();

        // Desactivar el estado de envío
        if (_isSubmitting) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    });

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Encabezado
              const Icon(Icons.location_on, size: 48, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                'Configurar Ubicación',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Ingresa el código proporcionado para configurar tu ubicación',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Campo de código
              TextFormField(
                controller: _codigoUbicacionController,
                decoration: InputDecoration(
                  labelText: 'Código de Ubicación',
                  hintText: 'Ej: 475985',
                  prefixIcon: const Icon(Icons.qr_code),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    tooltip:
                        _showPassword ? 'Ocultar código' : 'Mostrar código',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
                obscureText: !_showPassword,
                textInputAction: TextInputAction.done,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // Opcional: Formatear el código según tus necesidades
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\-]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el código de ubicación';
                  }
                  if (value.length < 5) {
                    return 'El código debe tener al menos 5 caracteres';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submitForm(),
              ),
              const SizedBox(height: 24),

              // Botón de acción
              FilledButton.icon(
                onPressed: _isSubmitting ? null : _submitForm,
                icon:
                    _isSubmitting
                        ? Container(
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.all(2.0),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                        : const Icon(Icons.save_outlined),
                label: Text(
                  _isSubmitting ? 'Configurando...' : 'Configurar Ubicación',
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // Botón alternativo para escanear QR (opcional)
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _isSubmitting ? null : _scanQRCode,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Escanear Código QR'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // Ayuda adicional
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _showHelpDialog,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '¿No tienes un código?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      final hasInternet = await ref.watch(networkInfoProvider).isConnected;
      final ubicacionState = ref.watch(ubicacionNotifierProvider);
      final notifier = ref.read(ubicacionNotifierProvider.notifier);

      if (!hasInternet) {
        NotificationUtils.showSnackBar(
          context: context,
          message: 'No hay conexión a internet',
          isError: false,
          icon: Icons.error,
        );

        setState(() {
          _isSubmitting = false;
        });
        return;
      }

      try {
        // Obtener el ID de ubicación
        final isVerify = await notifier.handleSubmitConfiguracionUbicacion(
          _codigoUbicacionController.text,
        );

        // Mostrar notificación de éxito
        if (mounted) {
          if (isVerify == true) {
            NotificationUtils.showSnackBar(
              context: context,
              message: 'Ubicación configurada correctamente',
              isError: false,
              icon: Icons.check_circle,
            );

            Navigator.of(context).pushNamed(AppRoutes.ubicacion);
          }
        } else {
          if (mounted) {
            NotificationUtils.showSnackBar(
              context: context,
              message:
                  ubicacionState.errorMessage ??
                  'Error al configurar ubicación',
              isError: true,
              icon: Icons.error_outline,
            );
          }
        }
      } catch (e) {
        // El error ya se maneja en el provider y se muestra en el build
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  void _scanQRCode() async {
    // Aquí implementarías la funcionalidad para escanear un código QR
    // Por ejemplo, usando el paquete mobile_scanner o qr_code_scanner

    // Ejemplo de implementación básica:
    NotificationUtils.showSnackBar(
      context: context,
      message: 'Función de escaneo QR próximamente',
      isError: false,
      icon: Icons.qr_code_scanner,
    );

    // Cuando tengas el código del QR:
    // _codigoUbicacionController.text = codigoEscaneado;
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ayuda con el Código de Ubicación'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Para configurar tu ubicación necesitas un código válido que debe ser proporcionado por un administrador.',
                ),
                SizedBox(height: 16),
                Text(
                  'Si no tienes un código, contacta a soporte técnico o a tu administrador para obtener uno.',
                ),
                SizedBox(height: 16),
                Text(
                  'El código puede ser ingresado manualmente o escaneado mediante un código QR si está disponible.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendido'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }
}
