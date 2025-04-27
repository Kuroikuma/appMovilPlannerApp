import '../../data/database.dart';

abstract class IHorarioRepository {
  Future<Horario> obtenerTodos(String ubicacionId);
  Future<Horario?> obtenerPorId(int id);
  Future<int> insertar(Horario horario);
  Future<bool> actualizar(Horario horario);
  Future<int> eliminar(int id);
}
