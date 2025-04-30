// core/injection_container.dart
import 'package:flutter_application_1/core/network/network_info.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/data/database_client.dart';
import 'package:flutter_application_1/data/mappers/trabajador_mappers.dart';
import 'package:flutter_application_1/data/repositories/local/trabajador_local.dart';
import 'package:flutter_application_1/data/repositories/remote/api_client.dart';
import 'package:flutter_application_1/data/repositories/remote/trabajador_remote.dart';
import 'package:flutter_application_1/data/repositories/sync_entity_repo.dart';
import 'package:flutter_application_1/data/repositories/trabajador.dart';
import 'package:flutter_application_1/domain/repositories.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../data/repositories/local/registro_diario_repository_local.dart';
import '../data/repositories/remote/registro_diario_repository_remote.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingletonAsync<AppDatabase>(() => DatabaseClient.database);

  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  // Registra NetworkInfo usando la implementación NetworkInfoImpl
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  );

  // getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // getIt.registerLazySingleton(() => Connectivity());

  // Locales (Drift)
  getIt.registerLazySingleton<TrabajadorLocalDataSource>(
    () => TrabajadorLocalDataSource(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      'https://plannerapptest.com/IntegracionExternaHoras',
    ), // Usando IP local
  );

  // Remotos
  getIt.registerLazySingleton<TrabajadorRemoteDataSource>(
    () => TrabajadorRemoteDataSource(getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<ISyncEntityRepository>(
    () => SyncEntityLocalDataSource(
      getIt<AppDatabase>(),
      getIt<TrabajadorRemoteDataSource>(),
      getIt<TrabajadorLocalDataSource>(),
      getIt<RegistroDiarioRepositoryLocal >(),
      getIt<RegistroDiarioRepositoryRemote >(),
      getIt<ApiClient>(),
    ),
  );

  // =================== REPOSITORIOS ===================
  getIt.registerLazySingleton<ITrabajadorRepository>(
    () => TrabajadorRepository(
      localDataSource: getIt<TrabajadorLocalDataSource>(),
      remoteDataSource: getIt<TrabajadorRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
      syncEntityRepository: getIt<ISyncEntityRepository>(),
      // conflictResolver: getIt<ConflictResolver>(),
    ),
  );

  // =================== MAPPERS ===================
  getIt.registerSingleton(TrabajadorMapper());
}
