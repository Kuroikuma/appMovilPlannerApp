import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/domain/models/registro_biometrico.dart';

import 'api_client.dart';

class RegistroBiometricoRepositoryRemote {
  final ApiClient _client;

  RegistroBiometricoRepositoryRemote(this._client);

  Future<List<RegistroBiometrico>> getFaces(int ubicacionId) async {
    try {
      final response = await _client.get(
        '/GetListRegistroBiometricoByCodigoUbicacionLocal?codigoUbicacionLocal=$ubicacionId',
      );
      if (response.statusCode != 200) {
        throw Exception('Error al obtener registros biometricos');
      }
      final jsonList = response.data as List;
      return jsonList.map((json) => RegistroBiometrico.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener registros biometricos');
    }
  }

  Future<void> saveFace(
    RegistroBiometrico registroBiometrico,
    XFile image,
  ) async {
    final file = await MultipartFile.fromFile(
      image.path,
      filename: image.name,
      contentType: DioMediaType('image/jpeg', 'image/png'),
    );

    await _client.post(
      '/PostSaveRegistroBiometrico',
      data: {'registroBiometrico': registroBiometrico, 'file': file},
    );
  }
}
