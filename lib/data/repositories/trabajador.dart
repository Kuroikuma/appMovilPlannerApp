import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/repositories/local/trabajador_local.dart';
import 'package:flutter_application_1/data/repositories/remote/trabajador_remote.dart';
import 'package:flutter_application_1/data/repositories/base_hybrid_repository.dart';
import 'package:flutter_application_1/domain/entities.dart';
import 'package:flutter_application_1/domain/repositories.dart';

import 'package:flutter_application_1/core/network/network_info.dart';
import 'package:flutter_application_1/core/error/exceptions.dart';

import '../converters/action_sync.dart';
import '../database.dart';
import '../mappers/trabajador_mappers.dart';

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
        insertQueuTrabajador(localTrabajador, TipoAccionesSync.post);
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
    final localData = await localDataSource.getAllTrabajadores();
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteData = await remoteDataSource.getAllTrabajadores(
          int.parse(ubicacionId),
        );
        await localDataSource.syncTrabajadores(remoteData);
        return remoteData;
      } catch (e) {
        return localData.isNotEmpty ? localData : throw CacheException();
      }
    } else {
      return localData.isNotEmpty ? localData : throw NoInternetException();
    }
  }

  //Sync Functions
  Future<void> insertQueuTrabajador(
    Trabajador trabajador,
    TipoAccionesSync action,
  ) async {
    syncEntityRepository.insertSyncEntity(
      SyncsEntitysCompanion(
        entityTableNameToSync: Value('trabajador'),
        action: Value(action),
        registerId: Value("{$trabajador.id}"),
        timestamp: Value(DateTime.now()),
        isSynced: Value(false),
        data: Value(TrabajadorMapper.toApiJson(trabajador)),
      ),
    );
  }
}
