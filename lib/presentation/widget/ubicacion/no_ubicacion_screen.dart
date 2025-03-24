import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../configurar_ubicacion_form.dart';

class NoUbicacionScreen extends ConsumerWidget {
  const NoUbicacionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05),

                // Logo o ícono de la aplicación
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.location_searching,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // Título principal
                Text(
                  '¡Bienvenido!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Subtítulo
                Text(
                  'Configura tu ubicación para comenzar',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),

                // Tarjeta de información
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildInfoStep(
                          context,
                          icon: Icons.qr_code,
                          title: 'Obtén un código',
                          description:
                              'Solicita un código de ubicación a tu administrador o escanea un código QR.',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoStep(
                          context,
                          icon: Icons.app_registration,
                          title: 'Registra tu ubicación',
                          description:
                              'Ingresa el código proporcionado para configurar tu ubicación.',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoStep(
                          context,
                          icon: Icons.check_circle_outline,
                          title: 'Verifica y comienza',
                          description:
                              'Una vez verificada tu ubicación, podrás comenzar a usar todas las funciones.',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Botón principal
                FilledButton.icon(
                  onPressed: () => _mostrarFormularioConfiguracion(context),
                  icon: const Icon(Icons.location_on),
                  label: const Text('Configurar mi ubicación'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Botón secundario
                OutlinedButton.icon(
                  onPressed: () => _mostrarInformacionAdicional(context),
                  icon: const Icon(Icons.help_outline),
                  label: const Text(
                    '¿Por qué necesito configurar mi ubicación?',
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoStep(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
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
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _mostrarFormularioConfiguracion(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder:
                (_, controller) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      // Indicador de arrastre
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Título
                      Text(
                        'Configurar Ubicación',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      // Formulario
                      const Expanded(child: ConfiurarUbicacionFormScreen()),
                    ],
                  ),
                ),
          ),
    );
  }

  void _mostrarInformacionAdicional(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Importancia de la Ubicación'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'La configuración de ubicación es necesaria para:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text('• Personalizar tu experiencia según tu ubicación física'),
                SizedBox(height: 8),
                Text('• Recibir notificaciones relevantes para tu área'),
                SizedBox(height: 8),
                Text('• Acceder a funciones específicas de tu ubicación'),
                SizedBox(height: 8),
                Text('• Garantizar la seguridad y el cumplimiento normativo'),
                SizedBox(height: 16),
                Text(
                  'No te preocupes, esto no implica un seguimiento constante de tu posición GPS. Solo necesitamos saber a qué ubicación estás asignado para brindarte la mejor experiencia.',
                  style: TextStyle(fontStyle: FontStyle.italic),
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
