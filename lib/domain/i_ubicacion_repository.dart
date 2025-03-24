import '../data/database.dart';

abstract class IUbicacionRepository {
  Future<List<Ubicacione>> obtenerUbicacionesPorGrupo(String grupoId);
  Future<List<Horario>> obtenerHorariosUbicacion(int ubicacionId);
  Future<Ubicacione> obtenerUbicacionConfigurada();
  Future<Ubicacione> configurarUbicacion(
    String codigoUbicacion,
    String ubicacionNombre,
    String ubicacionId,
  );
  Future<bool> verificarUbicacionConfiguradaLocal();
  Future<bool> verificarUbicacionConfiguradaRemota(String ubicacionId);
  Future<Map<String, dynamic>> getUbicacionByCodigoUbicacion(
    String codigoUbicacion,
  );
  Future<void> eliminarUbicacion(int ubicacionId);
}
