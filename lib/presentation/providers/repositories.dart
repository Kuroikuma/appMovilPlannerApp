import 'package:riverpod/riverpod.dart';

import '../../data/repositories/sync_entity_repo.dart';
import '../../data/repositories/trabajador.dart';
import '../../data/repositories/ubicacion_repo.dart';
import '../../domain/i_ubicacion_repository.dart';
import '../../domain/repositories.dart';
import 'data_sources.dart';
import 'providers.dart';

final syncEntityRepoProvider = Provider<ISyncEntityRepository>((ref) {
  return SyncEntityLocalDataSource(
    ref.watch(databaseProvider),
    ref.watch(trabajadorRemoteDataSourceProvider),
    ref.watch(trabajadorLocalDataSourceProvider),
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
