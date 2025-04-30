import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_application_1/core/error/exceptions.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/data/mappers/trabajador_mappers.dart';
import 'package:flutter_application_1/domain/entities.dart';

import '../../domain/models/registro_diario.dart';
import '../../domain/repositories.dart';
import '../converters/action_sync.dart';
import 'local/registro_diario_repository_local.dart';
import 'local/trabajador_local.dart';
import 'remote/api_client.dart';
import 'remote/registro_diario_repository_remote.dart';
import 'remote/trabajador_remote.dart';

class SyncEntityLocalDataSource implements ISyncEntityRepository {
  final AppDatabase _db;
  final TrabajadorRemoteDataSource trabajadorRemoteDataSource;
  final TrabajadorLocalDataSource trabajadorLocalDataSource;
  final RegistroDiarioRepositoryLocal registroDiarioLocalDataSource;
  final RegistroDiarioRepositoryRemote registroDiarioRepositoryRemote;
  final ApiClient _client;

  SyncEntityLocalDataSource(
    this._db,
    this.trabajadorRemoteDataSource,
    this.trabajadorLocalDataSource,
    this.registroDiarioLocalDataSource,
    this.registroDiarioRepositoryRemote,
    this._client,
  );

  @override
  Future<void> insertSyncEntity(SyncsEntitysCompanion syncEntity) async {
    await _db.into(_db.syncsEntitys).insertOnConflictUpdate(syncEntity);
  }

  @override
  Future<void> updateSyncEntity(SyncsEntitysCompanion syncEntity) async {
    await _db.update(_db.syncsEntitys).replace(syncEntity);
  }

  @override
  Future<SyncsEntity> getSyncEntityByTableNameAndId(
    String tableName,
    String registerId,
  ) async {
    final op =
        await (_db.select(_db.syncsEntitys)..where(
          (op) =>
              op.entityTableNameToSync.equals(tableName) &
              op.registerId.equals(registerId),
        )).getSingleOrNull();

    if (op == null) {
      throw Exception('SyncEntity not found');
    }

    return op;
  }

  @override
  Future<void> syncEntitys(List<Trabajador> trabajadores) async {
    await _db.batch((batch) {
      batch.deleteAll(_db.trabajadores);
      batch.insertAll(
        _db.trabajadores,
        trabajadores.map(TrabajadorMapper.toDataModel).toList(),
      );
    });
  }

  @override
  Future<void> syncRemoteWithLocalData() async {
    final pendingOperations = await getPendingLocalSyncOperations();

    // Agrupar operaciones por acción y entidad
    final Map<String, List<SyncEntity>> groupedOps = {};
    for (final op in pendingOperations) {
      final key = "${op.action}_${op.entityTableNameToSync}";
      groupedOps.putIfAbsent(key, () => []).add(op);
    }

    // Procesar cada grupo
    for (final entry in groupedOps.entries) {
      final parts = entry.key.split('_');
      final action = parts[0];
      final entity = parts[1];

      try {
        switch (action) {
          case 'CREATE':
            if (entity == 'trabajador') {
              // Obtener todos los datos del grupo
              final datos =
                  entry.value
                      .map((op) => TrabajadorMapper.fromApiJson(op.data))
                      .toList();
              await trabajadorRemoteDataSource.createTrabajadores(datos);
              await markMultipleAsSynced(
                entry.value,
              ); // Marcar todo el grupo como sincronizado
            }
            break;
          case 'UPDATE':
            if (entity == 'trabajador') {
              final updates =
                  entry.value
                      .map((op) => TrabajadorMapper.fromApiJson(op.data))
                      .toList();
              await trabajadorRemoteDataSource.updateTrabajadoresBatch(updates);
              await markMultipleAsSynced(entry.value);
            }
            break;
          case 'DELETE':
            if (entity == 'trabajador') {
              final deletes =
                  entry.value
                      .map((op) => TrabajadorMapper.fromApiJson(op.data))
                      .toList();
              await trabajadorRemoteDataSource.deleteTrabajadoresBatch(deletes);
              await markMultipleAsSynced(entry.value);
            }
            break;
        }

        if (entity == 'registroDiario') {
          await syncPendingChanges(entry.value);
        }
      } catch (e) {
        // Manejar error para todo el grupo
      }
    }
  }

  @override
  Future<void> syncLocalWithRemoteData() async {
    final pendingOperations = await getPendingRemoteSyncOperations();

    // Agrupar operaciones por acción y entidad
    final Map<String, List<SyncEntity>> groupedOps = {};
    for (final op in pendingOperations) {
      final key = "${op.action}_${op.entityTableNameToSync}";
      groupedOps.putIfAbsent(key, () => []).add(op);
    }

    // Procesar cada grupo
    for (final entry in groupedOps.entries) {
      final parts = entry.key.split('_');
      final action = parts[0];
      final entity = parts[1];

      try {
        switch (action) {
          case 'create':
            if (entity == 'trabajador') {
              // Obtener todos los datos del grupo
              final datos =
                  entry.value
                      .map((op) => TrabajadorMapper.fromApiJson(op.data))
                      .toList();
              await trabajadorLocalDataSource.createTrabajadores(datos);
              await markMultipleAsSynced(
                entry.value,
              ); // Marcar todo el grupo como sincronizado
            }
            break;
          case 'update':
            if (entity == 'trabajador') {
              final updates =
                  entry.value
                      .map((op) => TrabajadorMapper.fromApiJson(op.data))
                      .toList();
              await trabajadorLocalDataSource.updateTrabajadoresBatch(updates);
              await markMultipleAsSynced(entry.value);
            }
            break;
          case 'delete':
            if (entity == 'trabajador') {
              final deletes =
                  entry.value
                      .map((op) => TrabajadorMapper.fromApiJson(op.data))
                      .toList();
              await trabajadorLocalDataSource.deleteTrabajadoresBatch(deletes);
              await markMultipleAsSynced(entry.value);
            }
            break;
        }

        if (entity == 'registroDiario') {
          await fetchUpdatesFromServerRegistroDiario(entry.value);
        }
      } catch (e) {
        // Manejar error para todo el grupo
      }
    }
  }

  @override
  Future<List<SyncEntity>> getPendingLocalSyncOperations() async {
    final operations =
        await (_db.select(_db.syncsEntitys)
          ..where((op) => op.isSynced.equals(false))).get();

    return operations
        .map(
          (op) => SyncEntity(
            id: op.id,
            entityTableNameToSync: op.entityTableNameToSync,
            action: op.action,
            registerId: op.registerId,
            timestamp: op.timestamp,
            isSynced: op.isSynced,
            data: op.data,
          ),
        )
        .toList();
  }

  @override
  Future<List<SyncEntity>> getPendingRemoteSyncOperations() async {
    final operations = await _client.get(
      '/IntegracionExternaHoras/GetListRegistroSyncsEntityByTableName?tableName=RegistroDiario',
    );

    if (operations.data is List) {
      return operations.data
          .map(
            (op) => SyncEntity(
              id: op['id'],
              entityTableNameToSync: op['entityTableNameToSync'],
              action: op['action'],
              registerId: op['registerId'],
              timestamp: DateTime.parse(op['timestamp']),
              isSynced: op['isSynced'],
              data: op['data'],
            ),
          )
          .toList();
    } else {
      print('Unexpected response data type: ${operations.data.runtimeType}');
      throw ApiException();
    }
  }

  @override
  Future<void> markMultipleAsSynced(List<SyncEntity> operations) async {
    final ids = operations.map((op) => op.id).toList();
    await (_db.update(_db.syncsEntitys)..where(
      (op) => op.id.isIn(ids),
    )).write(const SyncsEntitysCompanion(isSynced: Value(true)));
  }

  Future<void> markSyncedByRegisterId(
    String registerId,
    TipoAccionesSync action,
  ) async {
    await (_db.update(_db.syncsEntitys)..where(
      (op) =>
          op.registerId.equals(registerId) &
          op.action.equals(TipoAccionesSyncConverter().toSql(action)),
    )).write(const SyncsEntitysCompanion(isSynced: Value(true)));
  }

  // logica solo para registro diario
  Future<void> fetchUpdatesFromServerRegistroDiario(
    List<SyncEntity> operations,
  ) async {
    try {
      for (var op in operations) {
        final registroJson = op.data;
        final servidorRegistro = RegistroDiario.fromJson(registroJson);

        final localRegistro = await registroDiarioLocalDataSource
            .buscarRegistroLocal(
              servidorRegistro.equipoId,
              servidorRegistro.fechaIngreso,
            );

        if (localRegistro == null) {
          // No existe local, insertarlo
          await registroDiarioLocalDataSource.insertarRegistroLocal(
            servidorRegistro,
          );
        } else {
          // Existe localmente
          // Aquí comparas y decides: por ahora, siempre sobreescribimos con el servidor
          await registroDiarioLocalDataSource.actualizarRegistroLocal(
            servidorRegistro,
          );

          await markSyncedByRegisterId(localRegistro.id.toString(), op.action);
        }
      }

      print('✅ Registros sincronizados desde el servidor');
    } catch (e) {
      print('❌ Error al sincronizar registros del servidor: $e');
    }
  }

  Future<void> syncPendingChanges(List<SyncEntity> cambios) async {
    print('📦 Cambios locales pendientes: ${cambios.length}');
    final updates =
        cambios.where((op) => op.action == TipoAccionesSync.update).toList();

    final create =
        cambios.where((op) => op.action == TipoAccionesSync.create).toList();

    final registrosDiarios = create.map((op) => op.data).toList();
    final updatesRegistrosDiarios = updates.map((op) => op.data).toList();

    await _client.post(
      'PostSaveMultipleRegistroDiarioByLocal',
      data: registrosDiarios.toString(),
    );

    await _client.put(
      'PostUpdateMultipleRegistroDiarioByLocal',
      data: updatesRegistrosDiarios.toString(),
    );

    // for (final cambio in cambios) {
    //   try {
    //     final dataJson = cambio.data; // El JSON ya mapeado

    //     if (cambio.action == TipoAccionesSync.create) {
    //       await registroDiarioRepositoryRemote.insertarRegistroDiario(dataJson);
    //     }
    //     //  else if (cambio.action == TipoAccionesSync.update) {
    //     //   await dio.put('/registros_diarios/${cambio.registerId}', data: parsedData);
    //     // } else if (cambio.action == TipoAccionesSync.delete) {
    //     //   await dio.delete('/registros_diarios/${cambio.registerId}');
    //     // }

    //     await markSyncedByRegisterId(cambio.registerId.toString(), cambio.action);
    //     print('✅ Cambio sincronizado exitosamente: ${cambio.id}');
    //   } catch (e) {
    //     print('❌ Error sincronizando cambio ${cambio.id}: $e');
    //     // Podrías aquí agregar retries o logs especiales
    //   }
    // }
  }
}
