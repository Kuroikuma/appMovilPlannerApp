// Archivo: providers/providers.dart
import 'package:drift/native.dart';
import 'package:flutter_application_1/core/network/network_info.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/data/repositories/remote/api_client.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod/riverpod.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(NativeDatabase.memory()); // Ejemplo en memoria
  ref.onDispose(() => db.close());
  return db;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient('https://api.tudominio.com');
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker.createInstance());
});

// final syncManagerProvider = Provider<SyncManager>((ref) {
//   return SyncManager(
//     db: ref.watch(databaseProvider),
//     networkInfo: ref.watch(networkInfoProvider),
//   );
// });
