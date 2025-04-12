import 'package:camera/camera.dart';
import 'package:flutter_application_1/domain/repositories/i_registro_biometrico_repository.dart';

import '../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/models/registro_biometrico.dart';
import 'local/registro_biometrico_repo_local.dart';
import 'local/trabajador_local.dart';
import 'remote/registro_biometrico_repo_remote.dart';

class RegistroBiometricoRepository extends IRegistroBiometricoRepository {
  final RegistroBiometricoRepositoryLocal localDataSource;
  final RegistroBiometricoRepositoryRemote remoteDataSource;
  final TrabajadorLocalDataSource trabajadorRepo;
  final NetworkInfo networkInfo;

  RegistroBiometricoRepository({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
    required this.trabajadorRepo,
  });

  @override
  Future<List<RegistroBiometrico>> getFaces(int ubicacionId) async {
    final localData = await localDataSource.getFaces();

    print(localData);

    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteData = await remoteDataSource.getFaces(ubicacionId);
        await localDataSource.syncronizarRegistrosBiometricos(remoteData);
        return remoteData;
      } catch (e) {
        return localData.isNotEmpty ? localData : throw CacheException();
      }
    } else {
      return localData.isNotEmpty ? localData : throw NoInternetException();
    }
  }

  @override
  Future<RegistroBiometrico> saveFace(
    int equipoId,
    List<double> embedding,
    XFile file,
    String imagenUrl,
  ) async {
    final registroBiometrico = await localDataSource.saveFace(
      equipoId,
      embedding,
    );

    final trabajador = await trabajadorRepo.getTrabajadorByEquipoId(equipoId);

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
      return registroBiometrico;
    }
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
