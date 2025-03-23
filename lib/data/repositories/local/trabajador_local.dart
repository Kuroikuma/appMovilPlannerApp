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
            primerApellido: Value(trabajador.primerApellido),
            segundoApellido: Value(trabajador.segundoApellido),
            equipoId: Value(trabajador.equipoId),
            estado: Value(trabajador.estado),
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
      primerApellido: trabajador.primerApellido,
      segundoApellido: trabajador.segundoApellido,
      equipoId: trabajador.equipoId,
      estado: Value(trabajador.estado),
    );

    final id = await _db.into(_db.trabajadores).insert(companion);
    return trabajador.copyWith(id: id);
  }

  Future<void> createTrabajadores(List<Trabajador> trabajadores) async {
    await _db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _db.trabajadores,
        trabajadores.map(TrabajadorMapper.toDataModel).toList(),
      );
    });
  }

  Future<void> updateTrabajadoresBatch(List<Trabajador> trabajadores) async {
    await _db.batch((batch) {
      for (final trabajador in trabajadores) {
        batch.update(
          _db.trabajadores,
          TrabajadorMapper.toDataModel(trabajador),
          where:
              (tbl) => tbl.id.equals(
                trabajador.id,
              ), // Asegura que uses la clave primaria
        );
      }
    });
  }

  Future<void> deleteTrabajadoresBatch(List<Trabajador> trabajadores) async {
    await _db.batch((batch) {
      for (final trabajador in trabajadores) {
        batch.deleteWhere(
          _db.trabajadores,
          (tbl) => tbl.id.equals(trabajador.id),
        );
      }
    });
  }
}
