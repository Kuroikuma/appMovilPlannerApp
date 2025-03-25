import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/utils/notification_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/use_case/ubicacion.dart';
import '../routes/app_routes.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // Evitar navegación si el widget fue desmontado

      if (state.isVerify == false) {
        Navigator.of(
          context,
        ).pushReplacementNamed(AppRoutes.configurarUbicacion);
      } else if (state.isVerify == true && state.ubicacion != null) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.ubicacion);
      }
    });

    // Mientras la navegación ocurre, muestra un loader para evitar parpadeos
    return const Center(child: CircularProgressIndicator());
  }
}
