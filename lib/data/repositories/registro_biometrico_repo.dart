import 'package:camera/camera.dart';
import 'package:drift/drift.dart';
import 'package:flutter_application_1/domain/repositories/i_registro_biometrico_repository.dart';
import '../../core/network/network_info.dart';
import '../../domain/models/registro_biometrico.dart';
import '../../domain/repositories.dart';
import '../converters/action_sync.dart';
import '../database.dart';
import 'local/registro_biometrico_repo_local.dart';
import 'local/trabajador_local.dart';
import 'remote/registro_biometrico_repo_remote.dart';

class RegistroBiometricoRepository extends IRegistroBiometricoRepository {
  final RegistroBiometricoRepositoryLocal localDataSource;
  final RegistroBiometricoRepositoryRemote remoteDataSource;
  final TrabajadorLocalDataSource trabajadorRepo;
  final ISyncEntityRepository syncEntityRepository;
  final NetworkInfo networkInfo;

  RegistroBiometricoRepository({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
    required this.trabajadorRepo,
    required this.syncEntityRepository,
  });

  @override
  Future<List<RegistroBiometrico>> getFaces(String codigo) async {
    final localData = await localDataSource.getFaces();

    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteData = await remoteDataSource.getFaces(codigo);
        await localDataSource.syncronizarRegistrosBiometricos(remoteData);
        return remoteData;
      } catch (e) {
        return localData.isNotEmpty ? localData : [];
      }
    } else {
      return localData.isNotEmpty ? localData : [];
    }
  }

  @override
  Future<RegistroBiometrico> saveFace(
    int trabajadorId,
    List<double> embedding,
    XFile file,
    String imagenUrl,
  ) async {
    final registroBiometrico = await localDataSource.saveFace(
      trabajadorId,
      embedding,
    );

    final trabajador = await trabajadorRepo.getTrabajadorByEquipoId(
      trabajadorId,
    );

    final updatedTrabajador = trabajador.copyWith(
      faceSync: true,
      fotoUrl: imagenUrl,
    );

    await trabajadorRepo.insertOrUpdateTrabajador(updatedTrabajador);

    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {

        file.saveTo(imagenUrl);
        await remoteDataSource.saveFace(registroBiometrico, file);
        return registroBiometrico;
      } catch (e) {
        return registroBiometrico;
      }
    } else {
      await insertQueuSyncRegistroBiometrico(
        registroBiometrico,
        TipoAccionesSync.create,
      );
      return registroBiometrico;
    }
  }

  Future<void> insertQueuSyncRegistroBiometrico(
    RegistroBiometrico registroBiometrico,
    TipoAccionesSync accion,
  ) async {
    syncEntityRepository.insertSyncEntity(
      SyncsEntitysCompanion(
        entityTableNameToSync: Value('registroBiometrico'),
        action: Value(accion),
        registerId: Value("{$registroBiometrico.id}"),
        timestamp: Value(DateTime.now()),
        isSynced: Value(false),
        data: Value(registroBiometrico.toJson()),
      ),
    );
  }

  @override
  Future<void> deleteFace(int id, String registroBiometricoId) async {
    await localDataSource.deleteFace(id, registroBiometricoId);
  }

  @override
  Future<void> deleteAllFaces() async {
    await localDataSource.deleteAll();
  }
}
