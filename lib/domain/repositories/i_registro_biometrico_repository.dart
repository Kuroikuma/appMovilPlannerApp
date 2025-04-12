import 'package:camera/camera.dart';

import '../models/registro_biometrico.dart';

abstract class IRegistroBiometricoRepository {
  Future<List<RegistroBiometrico>> getFaces(int ubicacionId);
  Future<RegistroBiometrico> saveFace(
    int equipoId,
    List<double> embedding,
    XFile image,
    String imagenUrl,
  );
  Future<void> deleteFace(int equipoId, String registroBiometricoId);
  Future<void> deleteAllFaces();
}
