import 'package:flutter_application_1/domain/repositories/i_registro_biometrico_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../../data/repositories/horario_repository.dart';
import '../../data/repositories/registro_biometrico_repo.dart';
import '../../data/repositories/registro_diario_repo.dart';
import '../../data/repositories/remote/reconocimiento_facial_repository.dart';
import '../../data/repositories/sync_entity_repo.dart';
import '../../data/repositories/trabajador.dart';
import '../../data/repositories/ubicacion_repo.dart';
import '../../domain/repositories/i_horario_repositorio.dart';
import '../../domain/repositories/i_reconocimiento_facial_repository.dart';
import '../../domain/repositories/i_registro_diario_repository.dart';
import '../../domain/repositories/i_ubicacion_repository.dart';
import '../../domain/repositories.dart';
import 'data_sources.dart';
import 'providers.dart';

final syncEntityRepoProvider = Provider<ISyncEntityRepository>((ref) {
  return SyncEntityLocalDataSource(
    ref.watch(databaseProvider),
    ref.watch(trabajadorRemoteDataSourceProvider),
    ref.watch(trabajadorLocalDataSourceProvider),
    ref.watch(registroDiarioLocalDataSourceProvider),
    ref.watch(registroDiarioRemoteDataSourceProvider),
    ref.watch(apiClientProvider),
  );
});

final trabajadorRepositoryProvider = Provider<ITrabajadorRepository>((ref) {
  return TrabajadorRepository(
    localDataSource: ref.watch(trabajadorLocalDataSourceProvider),
    remoteDataSource: ref.watch(trabajadorRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
    syncEntityRepository: ref.watch(syncEntityRepoProvider),
  );
});

final ubicacionRepositoryProvider = Provider<IUbicacionRepository>((ref) {
  return UbicacionRepo(
    ref.watch(databaseProvider),
    ref.watch(apiClientProvider),
  );
});

final registroDiarioRepositoryProvider = Provider<IRegistroDiarioRepository>((
  ref,
) {
  return RegistroDiarioRepository(
    localDataSource: ref.watch(registroDiarioLocalDataSourceProvider),
    remoteDataSource: ref.watch(registroDiarioRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
    syncEntityRepository: ref.watch(syncEntityRepoProvider),
  );
});

final registroBiometricoRepositoryProvider =
    Provider<IRegistroBiometricoRepository>((ref) {
      return RegistroBiometricoRepository(
        localDataSource: ref.watch(registroBiometricoLocalDataSourceProvider),
        remoteDataSource: ref.watch(registroBiometricoRemoteDataSourceProvider),
        networkInfo: ref.watch(networkInfoProvider),
        trabajadorRepo: ref.watch(trabajadorLocalDataSourceProvider),
        syncEntityRepository: ref.watch(syncEntityRepoProvider),
      );
    });

final reconocimientoFacialRepositoryProvider =
    Provider<IReconocimientoFacialRepository>((ref) {
      return ReconocimientoFacialRepository(
        ref.watch(registroDiarioRepositoryProvider),
      );
    });

final horarioRepositoryProvider = Provider<IHorarioRepository>((ref) {
  return HorarioRepository(
    ref.watch(databaseProvider),
    ref.watch(networkInfoProvider),
    ref.watch(apiClientProvider),
  );
});
