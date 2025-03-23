import 'package:drift/drift.dart';
import 'package:flutter_application_1/core/error/exceptions.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/data/mappers/trabajador_mappers.dart';
import 'package:flutter_application_1/domain/entities.dart';

import '../../domain/repositories.dart';
import 'local/trabajador_local.dart';
import 'remote/api_client.dart';
import 'remote/trabajador_remote.dart';

class SyncEntityLocalDataSource implements ISyncEntityRepository {
  final AppDatabase _db;
  final TrabajadorRemoteDataSource trabajadorRemoteDataSource;
  final TrabajadorLocalDataSource trabajadorLocalDataSource;
  final ApiClient _client;

  SyncEntityLocalDataSource(
    this._db,
    this.trabajadorRemoteDataSource,
    this.trabajadorLocalDataSource,
    this._client,
  );

  @override
  Future<void> insertSyncEntity(SyncEntity syncEntity) async {
    await _db
        .into(_db.syncsEntitys)
        .insertOnConflictUpdate(
          SyncsEntitysCompanion(
            entityTableNameToSync: Value(syncEntity.entityTableNameToSync),
            action: Value(syncEntity.action),
            registerId: Value(syncEntity.registerId),
            timestamp: Value(syncEntity.timestamp),
            isSynced: Value(syncEntity.isSynced),
            data: Value(syncEntity.data),
          ),
        );
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
    final operations = await _client.get('/sync-entities');

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
}
