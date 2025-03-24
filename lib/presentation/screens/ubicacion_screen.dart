import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widget/configurar_ubicacion_form.dart';
import 'package:flutter_application_1/presentation/utils/notification_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/use_case/ubicacion.dart';
import '../widget/ubicacion/no_ubicacion_screen.dart';
import '../widget/ubicacion/ubicacion_details_card.dart';

class UbicacionScreen extends ConsumerStatefulWidget {
  const UbicacionScreen({super.key});

  @override
  ConsumerState<UbicacionScreen> createState() => _UbicacionScreenState();
}

class _UbicacionScreenState extends ConsumerState<UbicacionScreen> {
  @override
  void initState() {
    super.initState();
    // Verificar ubicación al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(ubicacionNotifierProvider.notifier)
          .verificarUbicacionConfiguradaLocal();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ubicacionState = ref.watch(ubicacionNotifierProvider);
    final ubicacionNotifier = ref.read(ubicacionNotifierProvider.notifier);

    // Mostrar notificación si hay error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ubicacionState.errorType != null) {
        if (ubicacionState.errorType == UbicacionErrorType.noInternet) {
          NotificationUtils.showNoInternetNotification(context);
        } else {
          NotificationUtils.showSnackBar(
            context: context,
            message: ubicacionState.errorMessage ?? 'Ha ocurrido un error',
            isError: true,
          );
        }
        // Limpiar el error después de mostrarlo
        ubicacionNotifier.clearErrors();
      }
    });

    return Scaffold(
      body: SafeArea(
        child:
            ubicacionState.isLoading
                ? const Center(
                  child: CircularProgressIndicator(),
                ) // 🔄 Cargando
                : _buildBody(context, ubicacionState, ubicacionNotifier),
      ),
      // Botón flotante para verificar conexión manualmente (solo mostrar si ya hay una ubicación verificada)
      floatingActionButton:
          ubicacionState.isVerify == true
              ? FloatingActionButton(
                onPressed: () async {
                  await ubicacionNotifier.verificarUbicacionConfiguradaLocal();
                },
                tooltip: 'Verificar ubicación',
                child: const Icon(Icons.refresh),
              )
              : null,
    );
  }

  Widget _buildBody(
    BuildContext context,
    UbicacionState state,
    UbicacionNotifier notifier,
  ) {
    // Si isVerify es false, significa que aún no se ha verificado ninguna ubicación
    if (state.isVerify == false) {
      return const NoUbicacionScreen();
    }

    // Si isVerify es true, mostrar los detalles de la ubicación
    if (state.isVerify == true) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            state.ubicacion != null
                ? UbicacionDetailsCard(ubicacion: state.ubicacion!)
                : _buildEmptyState(context, notifier),
      );
    }

    // Si isVerify es false, mostrar el formulario de configuración
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: ConfiurarUbicacionFormScreen(),
    );
  }

  Widget _buildEmptyState(BuildContext context, UbicacionNotifier notifier) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            "No se encontró información de la ubicación",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () async {
              await notifier.verificarUbicacionConfiguradaLocal();
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Verificar nuevamente"),
          ),
        ],
      ),
    );
  }
}
