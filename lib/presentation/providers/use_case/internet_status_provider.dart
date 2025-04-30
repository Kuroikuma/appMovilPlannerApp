import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'sync_entity.dart';

final internetStatusProvider = Provider<InternetStatusService>((ref) {
  final service = InternetStatusService(ref);
  service.iniciar();
  return service;
});

class InternetStatusService {
  final Ref ref;
  late StreamSubscription<InternetConnectionStatus> _subscription;

  InternetStatusService(this.ref);

  void iniciar() {
    final network = InternetConnectionChecker.createInstance();
    _subscription = network.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        // Aquí ejecutas la función que quieras cuando vuelva el internet
        print('✅ Conexión restaurada');
        onInternetRestored();
      } else {
        print('⚠️ Sin conexión');
      }
    });
  }

  void onInternetRestored() {
    ref.read(syncEntityNotifierProvider.notifier).loadSyncEntity();
    print('🚀 Ejecutando función por reconexión');
  }

  void dispose() {
    _subscription.cancel();
  }
}
