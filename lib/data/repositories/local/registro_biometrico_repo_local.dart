import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/domain/models/registro_biometrico.dart';

import '../../converters/tipo_registro_biometrico.dart';

class RegistroBiometricoRepositoryLocal {
  final AppDatabase _db;

  RegistroBiometricoRepositoryLocal(this._db);

  Future<List<RegistroBiometrico>> getFaces() async {
    final result = await _db.select(_db.registrosBiometricos).get();
    return result.map(RegistroBiometrico.fromDataModel).toList();
  }

  Future<RegistroBiometrico> saveFace(
    int equipoId,
    List<double> embedding,
  ) async {
    print(equipoId);
    print(embedding);
    try {
      final registroBiometrico = RegistroBiometrico(
        id: uuid.v4(),
        trabajadorId: equipoId,
        datosBiometricos: embedding,
        estado: true,
        tipoRegistro: TipoRegistroBiometrico.face,
      );
      await _db
          .into(_db.registrosBiometricos)
          .insert(registroBiometrico.toDataModel());

      return registroBiometrico;
    } catch (e) {
      print('Error al guardar rostro: $e');
      throw e;
    }
  }

  Future<void> syncronizarRegistrosBiometricos(
    List<RegistroBiometrico> registrosBiometricos,
  ) async {
    try {
      await _db.batch((batch) {
        batch.deleteAll(_db.registrosBiometricos);
        batch.insertAll(
          _db.registrosBiometricos,
          registrosBiometricos
              .map(
                (e) => RegistrosBiometricosCompanion(
                  id: Value(e.id),
                  trabajadorId: Value(e.trabajadorId),
                  datosBiometricos: Value(e.datosBiometricos),
                  estado: Value(e.estado),
                  tipoRegistro: Value(e.tipoRegistro),
                ),
              )
              .toList(),
        );
      });
    } catch (e) {
      print('Error al sincronizar registros: $e');
    }
  }

  Future<void> deleteFace(int trabajadorId, String faceId) async {
    await _db.batch((batch) {
      batch.deleteWhere(
        _db.registrosBiometricos,
        (tbl) => tbl.id.equals(faceId) & tbl.trabajadorId.equals(trabajadorId),
      );
    });
  }

  Future<void> deleteAll() async {
    await _db.delete(_db.registrosBiometricos);
  }
}
