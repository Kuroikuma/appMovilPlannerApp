import 'package:flutter_application_1/core/error/exceptions.dart';
import 'package:flutter_application_1/data/mappers/trabajador_mappers.dart';
import 'package:flutter_application_1/domain/entities.dart';
import 'api_client.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class TrabajadorRemoteDataSource {
  final ApiClient _client;

  TrabajadorRemoteDataSource(this._client);

  Future<List<Trabajador>> getAllTrabajadores() async {
    try {
      final response = await _client.get('/trabajadores');
      if (response.data is String) {
        // Si es string, intentar parsearlo como JSON
        final List jsonList = json.decode(response.data);
        return jsonList
            .map((json) => TrabajadorMapper.fromApiJson(json))
            .toList();
      }
      return (response.data as List)
          .map((json) => TrabajadorMapper.fromApiJson(json))
          .toList();
    } on DioException {
      throw ApiException();
    }
  }

  Future<int> createTrabajador(Trabajador trabajador) async {
    final response = await _client.post(
      '/trabajadores',
      data: TrabajadorMapper.toApiJson(trabajador),
    );
    return response.data['id'];
  }

  Future<Trabajador?> getTrabajadorByCedula(String cedula) async {
    try {
      final response = await _client.get('/trabajadores/cedula/$cedula');
      if (response.statusCode == 404) return null;
      return TrabajadorMapper.fromApiJson(response.data);
    } on DioException {
      throw ApiException();
    }
  }
}
