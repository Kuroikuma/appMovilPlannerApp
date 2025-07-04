import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter_application_1/core/error/exceptions.dart';
import 'package:flutter_application_1/data/converters/date_converter.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/data/mappers/trabajador_mappers.dart';
import 'package:flutter_application_1/domain/entities.dart';

import '../../domain/models/registro_diario.dart';
import '../../domain/repositories.dart';
import '../converters/action_sync.dart';
import '../converters/json_converter.dart';
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
    await _db.into(_db.syncsEntitys).insert(syncEntity);
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

        if (entity == 'RegistroDiario') {
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
      '/GetListRegistroSyncsEntityByTableName?tableName=RegistroDiario',
    );

    List<SyncEntity> listSyncEntity = [];

    if (operations.data is List) {
      operations.data.map((op) {
        final dataJson = JsonConverter().fromSql(op['data']);
        final registroDiarioJson = {
          'registroDiarioId': int.parse(dataJson["Id"]),
          'horaAprobadaId': int.parse(dataJson["HoraAprobadaId"]),
          'equipoId':  int.parse(dataJson["EquipoId"]),
          'fechaIngreso': DateConverter().fromSqlFormat(dataJson["Fecha"]).toIso8601String(),
          'horaIngreso': dataJson["HoraIngreso"],
          'fechaSalida': DateConverter().fromSqlFormat(dataJson["FechaSalida"]).toIso8601String(),
          'horaSalida': dataJson["HoraSalida"],
          'estado': true,
        };

        final syncEntity = SyncEntity(
          id: op['id'],
          entityTableNameToSync: op['entityTableNameToSync'],
          action: TipoAccionesSyncConverter().fromSql(op['action']),
          registerId: dataJson["Id"],
          timestamp: DateTime.parse(op['timestamp']),
          isSynced: op['isSynced'],
          data: registroDiarioJson, // Convertir a JSON
        );

        listSyncEntity.add(syncEntity);
        // Aquí puedes hacer lo que necesites con el syncEntity

        return syncEntity;
      }).toList();

      return listSyncEntity;
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
    if (operations.isEmpty) {
      print('No hay cambios pendientes para sincronizar.');
      return;
    }

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

    if (cambios.isEmpty) {
      print('No hay cambios pendientes para sincronizar.');
      return;
    }
    final updates =
        cambios.where((op) => op.action == TipoAccionesSync.update).toList();

    final create =
        cambios.where((op) => op.action == TipoAccionesSync.post).toList();

    final registrosDiarios =
        create.map((op) {
          final dataConHoraAprobada = {
            ...op.data, // Copia las propiedades originales
            'horaAprobadaId': op.data["horarioId"],
          };
          return json.encode(dataConHoraAprobada);
        }).toList();

    final updatesRegistrosDiarios =
        updates.map((op) {
          final dataConHoraAprobada = {
            ...op.data, // Copia las propiedades originales
            'horaAprobadaId': op.data["horarioId"],
            'RegistroDiarioId': op.data["id"],
          };
          return json.encode(dataConHoraAprobada);
        }).toList();

    if (registrosDiarios.isEmpty && updatesRegistrosDiarios.isEmpty) {
      print('No hay registros diarios para sincronizar.');
      return;
    }

    if (registrosDiarios.isNotEmpty) {
      final Map<String, dynamic> data = {
        'listRegistroDiaro': registrosDiarios.toString(),
      };

      final createData = FormData.fromMap(data);

      await _client.post(
        '/PostSaveMultipleRegistroDiarioByLocal',
        data: createData,
      );

      await markMultipleAsSynced(create);

      print('Registros diarios insertados: ${registrosDiarios.length}');
    }

    if (updatesRegistrosDiarios.isNotEmpty) {
      final Map<String, dynamic> data = {
        'listRegistroDiaro': updatesRegistrosDiarios.toString(),
      };

      final updateData = FormData.fromMap(data);

      await _client.put(
        '/UpdateMultipleRegistroDiarioByLocal',
        data: updateData,
      );

      await markMultipleAsSynced(updates);
      print(
        'Registros diarios actualizados: ${updatesRegistrosDiarios.length}',
      );
    }
  }
}
