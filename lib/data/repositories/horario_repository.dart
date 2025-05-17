import 'package:drift/drift.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/i_horario_repositorio.dart';
import '../converters/date_converter.dart';
import '../converters/time_converter.dart';
import '../database.dart';
import 'remote/api_client.dart';

class HorarioRepository implements IHorarioRepository {
  final AppDatabase _db;
  final NetworkInfo networkInfo;
  final ApiClient _client;

  HorarioRepository(this._db, this.networkInfo, this._client);

  companionToModel(HorariosCompanion horario) {
    return Horario(
      id: horario.id.value,
      ubicacionId: horario.ubicacionId.value,
      fechaFin: horario.fechaFin.value,
      fechaInicio: horario.fechaInicio.value,
      finDescanso: horario.finDescanso.value,
      horaFin: horario.horaFin.value,
      horaInicio: horario.horaInicio.value,
      inicioDescanso: horario.inicioDescanso.value,
      pagaAlmuerzo: horario.pagaAlmuerzo.value,
      estado: horario.estado.value,
    );
  }

  @override
  Future<Horario?> obtenerTodos(String ubicacionId) async {
    final localData = await _db.select(_db.horarios).get();

    final isConnected = await networkInfo.isConnected;
    final now = DateTime.now();
    if (isConnected) {
      try {
        final remoteData = await _client.get(
          '/GetListHorarioByUbicacionId?ubicacionId=$ubicacionId&fechaInicio=$now&fechaFin=$now',
        );

        if (remoteData.data.isEmpty) {
          return null;
        }

        final remoteHorario = remoteData.data[0];

        final horario = HorariosCompanion.insert(
          id: Value(remoteHorario['horarioId']),
          ubicacionId: remoteHorario['ubicacionId'],
          fechaFin: DateConverter().fromSql(remoteHorario['fechaFin']),
          fechaInicio: DateConverter().fromSql(remoteHorario['fechaInicio']),
          finDescanso: TimeOfDayConverter().fromSql(
            remoteHorario['finDescanso'],
          ),
          horaFin: TimeOfDayConverter().fromSql(remoteHorario['horaFin']),
          horaInicio: TimeOfDayConverter().fromSql(remoteHorario['horaInicio']),
          inicioDescanso: TimeOfDayConverter().fromSql(
            remoteHorario['iniciaDescanso']
          ),
          pagaAlmuerzo: Value(remoteHorario['pagaAlmuerzo']),
          estado: Value(true),
        );
        await _db.into(_db.horarios).insert(horario); 
        return companionToModel(horario);
      } catch (e) {
        return localData[0];
      }
    } else {
      return localData[0];
    }
  }

  @override
  Future<Horario?> obtenerPorId(int id) {
    return (_db.select(_db.horarios)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  mapperToCompanion(Horario horario) {
    return HorariosCompanion.insert(
      id: Value(horario.id),
      ubicacionId: horario.ubicacionId,
      fechaFin: horario.fechaFin,
      fechaInicio: horario.fechaInicio,
      finDescanso: horario.finDescanso,
      horaFin: horario.horaFin,
      horaInicio: horario.horaInicio,
      inicioDescanso: horario.inicioDescanso,
      pagaAlmuerzo: Value(horario.pagaAlmuerzo),
      estado: Value(horario.estado),
    );
  }

  @override
  Future<int> insertar(Horario horario) {
    return _db.into(_db.horarios).insert(mapperToCompanion(horario));
  }

  @override
  Future<bool> actualizar(Horario horario) {
    return _db.update(_db.horarios).replace(mapperToCompanion(horario));
  }

  @override
  Future<int> eliminar(int id) {
    return (_db.delete(_db.horarios)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<Horario> obtenerTodosLocal() async {
    final localData = await _db.select(_db.horarios).get();

    return localData[0];
  }
}
