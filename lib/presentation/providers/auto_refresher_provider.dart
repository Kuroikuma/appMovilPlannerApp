import 'dart:async';
import 'package:flutter_application_1/presentation/providers/use_case/reconocimiento_facial.dart';
import 'package:flutter_application_1/presentation/providers/use_case/registro_diario.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'use_case/trabajador.dart';
import 'use_case/ubicacion.dart';

final autoRefresherProvider = Provider<AutoRefresher>((ref) {
  final refresher = AutoRefresher(ref);
  refresher.iniciar();
  return refresher;
});

class AutoRefresher {
  final Ref ref;
  Timer? _timer;

  AutoRefresher(this.ref);

  void iniciar() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(minutes: 30), (_) => _ejecutar());
    _ejecutar();
  }

  void _ejecutar() {
    final ubicacionId = ref.read(ubicacionNotifierProvider).ubicacionId;

    if (ubicacionId.isNotEmpty) {
      ref
          .read(trabajadorNotifierProvider.notifier)
          .cargarTrabajadores(ubicacionId);
      ref
          .read(registroDiarioNotifierProvider.notifier)
          .cargarRegistros(ubicacionId);
      ref
          .read(reconocimientoFacialNotifierProvider.notifier)
          .cargarRegistrosBiometricos();
      print("✅ Refresco automático ejecutado con ubicaciónId: $ubicacionId");
    } else {
      print(
        "⚠️ No hay ubicación configurada. Se omite la actualización de trabajadores.",
      );
    }
  }

  void cancelar() {
    _timer?.cancel();
  }
}
