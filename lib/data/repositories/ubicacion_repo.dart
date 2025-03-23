import 'package:uuid/uuid.dart';

import '../../domain/i_ubicacion_repository.dart';
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
  Future<bool> verificarUbicacionConfigurada() async {
    final result = await _db.select(_db.ubicaciones).get();
    return result.isNotEmpty;
  }

  @override
  Future<bool> verificarUbicacionConfiguradaRemota(String ubicacionId) async {
    final config = await _client.get(
      '/IntegracionExternaHoras/GetIntegracionUbicacionApp?ubicacionId=$ubicacionId',
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

  @override
  Future<Ubicacione> configurarUbicacion(
    String codigoUbicacion,
    String ubicacionId,
  ) async {
    final uuid = const Uuid();
    final codigoUbicacionLocal = uuid.v4();

    final config = Ubicacione(
      id: codigoUbicacionLocal,
      nombre: codigoUbicacion,
      grupoId: '',
      ubicacionId: int.parse(ubicacionId),
      estado: true,
    );

    await configurarUbicacionRemota(codigoUbicacion, codigoUbicacionLocal);

    await configurarUbicacionLocal(config);

    return config;
  }

  @override
  Future<String> obtenerUbicacionId(String codigoUbicacion) async {
    final config = await _client.get(
      '/IntegracionExternaHoras/GetUbicacionIdByCodigoUbicacion?codigoUbicacion=$codigoUbicacion',
    );

    final configData = config.data;

    return configData.toString();
  }

  Future<Ubicacione> configurarUbicacionRemota(
    String codigoUbicacion,
    String codigoUbicacionLocal,
  ) async {
    print('codigoUbicacion: $codigoUbicacion');
    print('codigoUbicacionLocal: $codigoUbicacionLocal');
    final config = await _client.post(
      '/IntegracionExternaHoras/PostSaveIntegracionUbicacionApp',
      data: {
        'codigoUbicacion': codigoUbicacion,
        'codigoUbicacionLocal': codigoUbicacionLocal,
      },
    );

    final configData = config.data;

    if (configData['success']) {
      return Ubicacione(
        id: configData['id'],
        nombre: configData['nombre'],
        grupoId: configData['grupoId'],
        ubicacionId: configData['ubicacionId'],
        estado: configData['estado'],
      );
    } else {
      throw Exception('Error al configurar ubicación');
    }
  }

  Future<void> configurarUbicacionLocal(Ubicacione ubicacion) async {
    final result = await _db.into(_db.ubicaciones).insert(ubicacion);
    if (result > 0) {
      return;
    }
  }

  @override
  Future<void> eliminarUbicacion() async {
    await _db.delete(_db.ubicaciones);
  }
}
