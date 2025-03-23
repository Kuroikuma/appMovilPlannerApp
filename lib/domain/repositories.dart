import 'package:flutter_application_1/domain/entities.dart';

abstract class ITrabajadorRepository {
  Future<Trabajador> crearTrabajador(Trabajador trabajador);
  Future<List<Trabajador>> obtenerTodosTrabajadores();
}

abstract class ISyncEntityRepository {
  Future<void> insertSyncEntity(SyncEntity syncEntity);
  Future<void> syncEntitys(List<Trabajador> trabajadores);
  Future<void> syncRemoteWithLocalData();
  Future<void> syncLocalWithRemoteData();
  Future<List<SyncEntity>> getPendingLocalSyncOperations();
  Future<List<SyncEntity>> getPendingRemoteSyncOperations();
  Future<void> markMultipleAsSynced(List<SyncEntity> operations);
}

abstract class IRegistroRepository {
  Future<RegistroDiario> registrarIngreso(RegistroBiometrico registro);
  Future<RegistroDiario> registrarSalida(RegistroBiometrico registro);
}
