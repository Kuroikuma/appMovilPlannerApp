import '../entities.dart';
import '../models/reconocimiento_facial.dart';

abstract class IReconocimientoFacialRepository {
  Future<List<ReconocimientoFacial>> obtenerReconocimientosPorTrabajador(
    String trabajadorId,
  );
  Future<ReconocimientoFacial> registrarReconocimientoFacial(
    String trabajadorId,
    String imagenBase64,
  );
  Future<Trabajador?> identificarTrabajador(String imagenBase64);
  Future<bool> registrarAsistenciaPorReconocimiento(String trabajadorId);
  Future<bool> eliminarReconocimientoFacial(String reconocimientoId);
}
