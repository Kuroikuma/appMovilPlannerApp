import 'package:camera/camera.dart';

import '../models/registro_biometrico.dart';

abstract class IRegistroBiometricoRepository {
  Future<List<RegistroBiometrico>> getFaces(String codigo);
  Future<RegistroBiometrico> saveFace(
    int trabajadorId,
    List<double> embedding,
    XFile image,
    String imagenUrl,
  );
  Future<void> deleteFace(int equipoId, String registroBiometricoId);
  Future<void> deleteAllFaces();
}
