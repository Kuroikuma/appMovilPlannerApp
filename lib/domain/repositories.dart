import 'package:flutter_application_1/domain/entities.dart';

import '../data/database.dart';

abstract class ITrabajadorRepository {
  Future<Trabajador> crearTrabajador(Trabajador trabajador);
  Future<List<Trabajador>> obtenerTrabajadoresPorUbicacion(String ubicacionId);
}

abstract class ISyncEntityRepository {
  Future<void> insertSyncEntity(SyncsEntitysCompanion syncEntity);
  Future<void> syncEntitys(List<Trabajador> trabajadores);
  Future<void> syncRemoteWithLocalData();
  Future<void> syncLocalWithRemoteData();
  Future<List<SyncEntity>> getPendingLocalSyncOperations();
  Future<List<SyncEntity>> getPendingRemoteSyncOperations();
  Future<void> markMultipleAsSynced(List<SyncEntity> operations);
}
