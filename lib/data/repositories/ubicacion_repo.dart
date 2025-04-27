import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repositories/i_ubicacion_repository.dart';
import '../database.dart';
import 'remote/api_client.dart';

class UbicacionRepo implements IUbicacionRepository {
  final AppDatabase _db;
  final ApiClient _client;

  UbicacionRepo(this._db, this._client);

  @override
  Future<List<Ubicacione>> obtenerUbicacionesPorGrupo(String grupoId) async {
    final result = await _db.select(_db.ubicaciones).get();
    return result;
  }

  @override
  Future<bool> verificarUbicacionConfiguradaLocal() async {
    final result = await _db.select(_db.ubicaciones).get();
    return result.isNotEmpty;
  }

  @override
  Future<bool> verificarUbicacionConfiguradaRemota(String ubicacionId) async {
    final config = await _client.get(
      '/GetIntegracionUbicacionApp?ubicacionId=$ubicacionId',
    );

    final configData = config.data;

    return configData['configurado'];
  }

  @override
  Future<List<Horario>> obtenerHorariosUbicacion(int ubicacionId) async {
    final horarios =
        await (_db.select(_db.horarios)
          ..where((op) => op.ubicacionId.equals(ubicacionId))).get();
    return horarios;
  }

  @override
  Future<Ubicacione> obtenerUbicacionConfigurada() async {
    final result = await _db.select(_db.ubicaciones).get();
    return result.first;
  }

  Future<String> obtenerHorarioId(int ubicacionId) async {
    final horarios = await _client.get(
      'GetListHorarioByUbicacionId?ubicacionid=$ubicacionId&fechaInicio=2023-08-23&fechaFin=2025-04-23',
    );

    return horarios.data[0]?.horarioId ?? '24845';
  }

  @override
  Future<Ubicacione> configurarUbicacion(
    String codigoUbicacion,
    String ubicacionNombre,
    String ubicacionId,
  ) async {
    final uuid = const Uuid();
    final codigoUbicacionLocal = uuid.v4();

    final config = Ubicacione(
      id: codigoUbicacionLocal,
      nombre: ubicacionNombre,
      ubicacionId: int.parse(ubicacionId),
      estado: true,
      codigoUbicacion: int.parse(codigoUbicacion),
    );

    await configurarUbicacionRemota(codigoUbicacion, codigoUbicacionLocal);
    await configurarUbicacionLocal(config);

    return config;
  }

  @override
  Future<Map<String, dynamic>> getUbicacionByCodigoUbicacion(
    String codigoUbicacion,
  ) async {
    final config = await _client.get(
      '/GetUbicacionByCodigoUbicacion?codigoUbicacion=$codigoUbicacion',
    );

    final ubicacionId = config.data['ubicacionId'].toString();
    final ubicacionNombre = config.data['ubicacion'];

    return {'ubicacionId': ubicacionId, 'ubicacionNombre': ubicacionNombre};
  }

  Future<bool> configurarUbicacionRemota(
    String codigoUbicacion,
    String codigoUbicacionLocal,
  ) async {
    final formData = FormData.fromMap({
      'codigoUbicacion': codigoUbicacion,
      'codigoUbicacionLocal': codigoUbicacionLocal,
    });

    try {
      await _client.post('/PostSaveIntegracionUbicacionApp', data: formData);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> configurarUbicacionLocal(Ubicacione ubicacion) async {
    try {
      final result = await _db
          .into(_db.ubicaciones)
          .insert(
            UbicacionesCompanion.insert(
              id: ubicacion.id,
              nombre: ubicacion.nombre,
              ubicacionId: ubicacion.ubicacionId,
              estado: Value(ubicacion.estado),
              codigoUbicacion: ubicacion.codigoUbicacion,
            ),
          );

      if (result > 0) {
        return;
      }
    } catch (e) {
      print('Error al configurar ubicación local: $e');
    }
  }

  @override
  Future<void> eliminarUbicacion(int ubicacionId) async {
    await _db.batch((batch) {
      batch.deleteAll(_db.ubicaciones);
      batch.deleteAll(_db.gruposUbicaciones);
      batch.deleteAll(_db.trabajadores);
      batch.deleteAll(_db.horarios);
      batch.deleteAll(_db.syncsEntitys);
      batch.deleteAll(_db.registrosBiometricos);
      batch.deleteAll(_db.reconocimientosFacial);
      batch.deleteAll(_db.registrosDiarios);
    });

    await _client.delete(
      '/DeleteIntegracionUbicacionApp?ubicacionId=$ubicacionId',
    );
  }

  @override
  Future<String> obtenerCodigoUbicacion(int ubicacionId) async {
    try {
      final result = await _client.get(
        '/GetIntegracionUbicacionApp?ubicacionId=$ubicacionId',
      );

      return result.data['codigoConfiguracion'];
    } catch (e) {
      print('Error al obtener el código de ubicación: $e');
      rethrow;
    }
  }
}
