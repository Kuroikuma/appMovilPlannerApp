// Archivo: providers/providers.dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_application_1/core/network/network_info.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/data/repositories/remote/api_client.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:path/path.dart' as p;

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(
    _openDatabase(),
  ); // Usa la función para abrir la BD de forma persistente
  ref.onDispose(() => db.close());
  return db;
});

// Función para abrir la base de datos en un archivo persistente
LazyDatabase _openDatabase() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));

    // if (await file.exists()) {
    //   await file.delete();
    //   print("🔄 Base de datos eliminada y reiniciada.");
    // }

    return NativeDatabase(file);
  });
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    'https://plannerapptest.com/IntegracionExternaHoras',
  ); // Usando IP local
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(InternetConnectionChecker.createInstance());
});
