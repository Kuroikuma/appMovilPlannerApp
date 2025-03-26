import 'dart:io';

import 'package:flutter_application_1/data/repositories/local/trabajador_local.dart';
import 'package:flutter_application_1/data/repositories/remote/trabajador_remote.dart';
import 'package:flutter_application_1/data/repositories/base_hybrid_repository.dart';
import 'package:flutter_application_1/domain/entities.dart';
import 'package:flutter_application_1/domain/repositories.dart';

import 'package:flutter_application_1/core/network/network_info.dart';
import 'package:flutter_application_1/core/error/exceptions.dart';

class TrabajadorRepository
    implements ITrabajadorRepository, BaseHybridRepository {
  final TrabajadorLocalDataSource localDataSource;
  final TrabajadorRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final ISyncEntityRepository syncEntityRepository;

  TrabajadorRepository({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
    required this.syncEntityRepository,
  });

  @override
  Future<Trabajador> crearTrabajador(Trabajador trabajador) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteId = await remoteDataSource.createTrabajador(trabajador);
        final newTrabajador = trabajador.copyWith(id: remoteId);
        await localDataSource.insertOrUpdateTrabajador(newTrabajador);
        return newTrabajador;
      } else {
        final localTrabajador = await localDataSource.insertOfflineTrabajador(
          trabajador,
        );
        // syncEntityRepository.insertSyncEntity(
        //   SyncEntity(
        //     id: localTrabajador.id,
        //     entityTableNameToSync: 'trabajador',
        //     action: 'CREATE',
        //     registerId: "{$localTrabajador.id}",
        //     timestamp: DateTime.now(),
        //     isSynced: false,
        //     data: TrabajadorMapper.toApiJson(localTrabajador),
        //   ),
        // );
        return localTrabajador.copyWith(id: localTrabajador.id);
      }
    } on SocketException {
      throw NetworkException();
    }
  }

  @override
  Future<void> handleOfflineOperations() {
    // TODO: implement handleOfflineOperations
    throw UnimplementedError();
  }

  @override
  // TODO: implement isConnected
  bool get isConnected => throw UnimplementedError();

  @override
  Future<void> syncLocalWithRemote() {
    // TODO: implement syncLocalWithRemote
    throw UnimplementedError();
  }

  @override
  Future<List<Trabajador>> obtenerTrabajadoresPorUbicacion(
    String ubicacionId,
  ) async {
    print('obtenerTrabajadoresPorUbicacion');
    final localData = await localDataSource.getAllTrabajadores();
    final isConnected = await networkInfo.isConnected;
    print('Local data: $localData');
    if (isConnected) {
      try {
        final remoteData = await remoteDataSource.getAllTrabajadores(
          int.parse(ubicacionId),
        );
        print('Remote data: $remoteData');
        await localDataSource.syncTrabajadores(remoteData);
        return remoteData;
      } catch (e) {
        return localData.isNotEmpty ? localData : throw CacheException();
      }
    } else {
      return localData.isNotEmpty ? localData : throw NoInternetException();
    }
  }

  // @override
  // Future<void> syncLocalWithRemote() async {
  //   final pendingOperations = await localDataSource.getPendingSyncOperations();

  //   for (final operation in pendingOperations) {
  //     try {
  //       switch (operation.action) {
  //         case 'create':
  //           await remoteDataSource.createTrabajador(operation.data);
  //           await localDataSource.markOperationAsSynced(operation.id);
  //           break;
  //         case 'update':
  //         // Lógica similar para updates
  //       }
  //     } catch (e) {
  //       // Registrar error y reintentar luego
  //     }
  //   }
  // }

  // Resto de implementaciones...
}
