import 'package:flutter_application_1/data/repositories/local/trabajador_local.dart';
import 'package:flutter_application_1/data/repositories/remote/trabajador_remote.dart';
import 'package:flutter_application_1/presentation/providers/providers.dart';
import 'package:riverpod/riverpod.dart';

import '../../data/repositories/local/registro_diario_repository_local.dart';
import '../../data/repositories/remote/registro_diario_repository_remote.dart';

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

final registroDiarioRemoteDataSourceProvider =
    Provider<RegistroDiarioRepositoryRemote>((ref) {
      return RegistroDiarioRepositoryRemote(ref.watch(apiClientProvider));
    });

final registroDiarioLocalDataSourceProvider =
    Provider<RegistroDiarioRepositoryLocal>((ref) {
      return RegistroDiarioRepositoryLocal(ref.watch(databaseProvider));
    });
