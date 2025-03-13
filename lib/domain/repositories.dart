import 'package:flutter_application_1/domain/entities.dart';

abstract class ITrabajadorRepository {
  Future<Trabajador> crearTrabajador(Trabajador trabajador);
  Future<List<Trabajador>> obtenerTodosTrabajadores();
  Future<Trabajador?> obtenerTrabajadorPorCedula(String cedula);
}

abstract class IUbicacionRepository {
  Future<List<Ubicacion>> obtenerUbicacionesPorGrupo(String grupoId);
  Future<Horario> obtenerHorarioUbicacion(String ubicacionId);
}

abstract class IRegistroRepository {
  Future<RegistroDiario> registrarIngreso(RegistroBiometrico registro);
  Future<RegistroDiario> registrarSalida(RegistroBiometrico registro);
}
