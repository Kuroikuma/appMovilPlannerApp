import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widget/configurar_ubicacion_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/use_case/ubicacion.dart';

class UbicacionScreen extends ConsumerWidget {
  const UbicacionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ubicacionState = ref.watch(ubicacionNotifierProvider);
    final ubicacionNotifier = ref.read(ubicacionNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración de Ubicación"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              ref
                  .read(ubicacionNotifierProvider.notifier)
                  .verificarUbicacionConfiguradaLocal();
            },
            tooltip: 'Configurar App biométrica',
          ),
        ],
      ),
      body: Center(
        child:
            ubicacionState.isLoading
                ? const CircularProgressIndicator() // 🔄 Cargando
                : ubicacionState.isVerify == true
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ubicación: ${ubicacionState.ubicacion?.nombre ?? 'Desconocida'}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Ubicación Verificada",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        await ubicacionNotifier
                            .verificarUbicacionConfiguradaLocal();
                      },
                      child: const Text("Verificar Ubicación"),
                    ),
                  ],
                )
                : ubicacionState.isVerify == false
                ? const ConfiurarUbicacionFormScreen()
                : const Text("PlannerApp"),
      ),
    );
  }
}
