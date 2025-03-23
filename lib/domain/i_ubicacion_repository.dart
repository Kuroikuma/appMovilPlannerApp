import '../data/database.dart';

abstract class IUbicacionRepository {
  Future<List<Ubicacione>> obtenerUbicacionesPorGrupo(String grupoId);
  Future<List<Horario>> obtenerHorariosUbicacion(int ubicacionId);
  Future<Ubicacione> obtenerUbicacionConfigurada();
  Future<Ubicacione> configurarUbicacion(
    String codigoUbicacion,
    String ubicacionId,
  );
  Future<bool> verificarUbicacionConfigurada();
  Future<bool> verificarUbicacionConfiguradaRemota(String ubicacionId);
  Future<String> obtenerUbicacionId(String codigoUbicacion);
  Future<void> eliminarUbicacion();
}
