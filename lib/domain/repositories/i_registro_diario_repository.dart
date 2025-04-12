import '../models/registro_diario.dart';

abstract class IRegistroDiarioRepository {
  Future<List<RegistroDiario>> obtenerRegistrosPorUbicacion(
    String ubicacionId, {
    DateTime? fecha,
  });
  Future<RegistroDiario?> obtenerRegistroPorId(int id);
  Future<RegistroDiario> registrarEntrada(
    int equipoId, {
    int? reconocimientoFacialId,
  });
  Future<RegistroDiario> registrarSalida(
    int registroId, {
    int? reconocimientoFacialId,
  });
  Future<List<RegistroDiario>> obtenerRegistrosPorTrabajador(
    int equipoId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  });
  Future<void> cambiarEstadoRegistro(int registroId, bool estado);
  Future<List<RegistroDiario>> obtenerRegistrosPorRangoFechas(
    String ubicacionId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  });
}
