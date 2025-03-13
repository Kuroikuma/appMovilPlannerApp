import 'package:flutter_application_1/data/repositories/local/trabajador_local.dart';
import 'package:flutter_application_1/data/repositories/remote/trabajador_remote.dart';
import 'package:flutter_application_1/presentation/providers/providers.dart';
import 'package:riverpod/riverpod.dart';

final trabajadorLocalDataSourceProvider = Provider<TrabajadorLocalDataSource>((
  ref,
) {
  return TrabajadorLocalDataSource(ref.watch(databaseProvider));
});

final trabajadorRemoteDataSourceProvider = Provider<TrabajadorRemoteDataSource>(
  (ref) {
    return TrabajadorRemoteDataSource(ref.watch(apiClientProvider));
  },
);
