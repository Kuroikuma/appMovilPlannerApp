import '../models/registro_diario.dart';

abstract class IRegistroDiarioRepository {
  Future<List<RegistroDiario>> obtenerRegistrosPorUbicacion(
    String ubicacionId, {
    DateTime? fecha,
  });
  Future<RegistroDiario?> obtenerRegistroPorId(int id);
  Future<RegistroDiario> registrarAsistencia(
    int equipoId,
    int horaAprobadaId,
  );
  Future<List<RegistroDiario>> obtenerRegistrosPorTrabajador(
    int equipoId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  });
  Future<List<RegistroDiario>> obtenerRegistrosPorRangoFechas(
    String ubicacionId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  });
}
