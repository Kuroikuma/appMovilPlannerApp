import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/domain/models/registro_biometrico.dart';

import 'api_client.dart';

class RegistroBiometricoRepositoryRemote {
  final ApiClient _client;

  RegistroBiometricoRepositoryRemote(this._client);

  Future<List<RegistroBiometrico>> getFaces(String codigoUbicacionLocal) async {
    try {
      final response = await _client.get(
        '/GetListRegistroBiometricoByCodigoUbicacionLocal?codigoUbicacionLocal=$codigoUbicacionLocal',
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
    try {
      final file = await MultipartFile.fromFile(
        image.path,
        filename: image.name,
        contentType: DioMediaType('image/jpeg', 'image/png'),
      );

      final formData = FormData.fromMap({
        'registroBiometrico': {
          ...registroBiometrico.toJson(),
          'datosBiometricos': registroBiometrico.datosBiometricos.toString(),
        },
        'file': file,
      });

      await _client.post('/PostSaveRegistroBiometrico', data: formData);
    } catch (e) {
      print(e);
      throw Exception('Error al guardar el rostro');
    }
  }

  Future<void> deleteFace(String codigoRegistroBiometrico) async {
    try {
      await _client.delete(
        '/DeleteRegistroBiometrico?registroBiometricoId=$codigoRegistroBiometrico',
      );
    } catch (e) {
      print(e);
      throw Exception('Error al eliminar el rostro');
    }
  }
}
