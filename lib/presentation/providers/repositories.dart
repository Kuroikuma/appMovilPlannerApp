import 'package:riverpod/riverpod.dart';

import '../../data/repositories/trabajador.dart';
import '../../domain/repositories.dart';
import 'data_sources.dart';
import 'providers.dart';

final trabajadorRepositoryProvider = Provider<ITrabajadorRepository>((ref) {
  return TrabajadorRepository(
    localDataSource: ref.watch(trabajadorLocalDataSourceProvider),
    remoteDataSource: ref.watch(trabajadorRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
    // syncManager: ref.watch(syncManagerProvider),
  );
});
