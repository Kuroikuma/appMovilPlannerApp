import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/data/mappers/trabajador_mappers.dart';
import 'package:flutter_application_1/domain/entities.dart';

class TrabajadorLocalDataSource {
  final AppDatabase _db;

  TrabajadorLocalDataSource(this._db);

  Future<void> insertOrUpdateTrabajador(Trabajador trabajador) async {
    await _db
        .into(_db.trabajadores)
        .insertOnConflictUpdate(
          TrabajadoresCompanion(
            nombre: Value(trabajador.nombre),
            apellido: Value(trabajador.apellido),
            cedula: Value(trabajador.cedula),
            activo: Value(trabajador.activo),
            ultimaActualizacion: Value(DateTime.now()),
          ),
        );
  }

  Future<List<Trabajador>> getAllTrabajadores() async {
    final result = await _db.select(_db.trabajadores).get();
    return result.map(TrabajadorMapper.fromDataModel).toList();
  }

  Future<void> syncTrabajadores(List<Trabajador> trabajadores) async {
    await _db.batch((batch) {
      batch.deleteAll(_db.trabajadores);
      batch.insertAll(
        _db.trabajadores,
        trabajadores.map(TrabajadorMapper.toDataModel).toList(),
      );
    });
  }

  Future<Trabajador> insertOfflineTrabajador(Trabajador trabajador) async {
    final companion = TrabajadoresCompanion.insert(
      nombre: trabajador.nombre,
      apellido: trabajador.apellido,
      cedula: trabajador.cedula,
      activo: Value(trabajador.activo),
      ultimaActualizacion: Value(trabajador.ultimaActualizacion),
    );

    final id = await _db.into(_db.trabajadores).insert(companion);
    return trabajador.copyWith(id: id);
  }

  Future<Trabajador?> getTrabajadorByCedula(String cedula) async {
    final result =
        await (_db.select(_db.trabajadores)
          ..where((t) => t.cedula.equals(cedula))).getSingleOrNull();

    return result != null ? TrabajadorMapper.fromDataModel(result) : null;
  }

  // Future<List<SyncEntityD>> getPendingSyncOperations() async {
  //   final operations =
  //       await _db
  //           .select(_db.syncEntitys)
  //           .where((op) => op.synced.equals(false))
  //           .get();
  //   return operations
  //       .map(
  //         (op) => SyncOperation(
  //           id: op.id,
  //           type: op.type,
  //           data: Trabajador(
  //             id: op.entityId,
  //             nombre: op.data['nombre'],
  //             apellido: op.data['apellido'],
  //             cedula: op.data['cedula'],
  //             activo: op.data['activo'],
  //           ),
  //         ),
  //       )
  //       .toList();
  // }

  // Future<void> markOperationAsSynced(String operationId) async {
  //   await (_db.update(_db.syncOperations)..where(
  //     (op) => op.id.equals(operationId),
  //   )).write(const SyncOperationsCompanion(synced: Value(true)));
  // }
}

class SyncOperation {
  final String id;
  final String type;
  final Trabajador data;

  SyncOperation({required this.id, required this.type, required this.data});
}
