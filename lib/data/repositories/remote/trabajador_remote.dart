import 'package:flutter_application_1/core/error/exceptions.dart';
import 'package:flutter_application_1/data/mappers/trabajador_mappers.dart';
import 'package:flutter_application_1/domain/entities.dart';
import 'api_client.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class TrabajadorRemoteDataSource {
  final ApiClient _client;

  TrabajadorRemoteDataSource(this._client);

  Future<List<Trabajador>> getAllTrabajadores(int ubicacionId) async {
    try {
      final response = await _client.get(
        '/GetListTrabajadorByUbicacionId?ubicacionId=$ubicacionId',
      );

      List<dynamic> jsonList;
      if (response.data is String) {
        try {
          jsonList = json.decode(response.data);
        } catch (e) {
          throw ApiException();
        }
      } else if (response.data is List) {
        jsonList = response.data;
      } else {
        throw ApiException();
      }

      return jsonList.map((json) {
        try {
          if (json is! Map<String, dynamic>) {
            throw ApiException();
          }
          return TrabajadorMapper.fromApiJson(json);
        } catch (e) {
          rethrow;
        }
      }).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException();
      }
      throw ApiException();
    } catch (e) {
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

  Future<List<Trabajador>> createTrabajadores(
    List<Trabajador> trabajadores,
  ) async {
    final response = await _client.post(
      '/trabajadores/many',
      data: trabajadores.map(TrabajadorMapper.toApiJson).toList(),
    );
    return response.data
        .map((json) => TrabajadorMapper.fromApiJson(json))
        .toList();
  }

  Future<List<Trabajador>> updateTrabajadoresBatch(
    List<Trabajador> trabajadores,
  ) async {
    final response = await _client.post(
      '/trabajadores/update-batch',
      data: trabajadores.map(TrabajadorMapper.toApiJson).toList(),
    );
    return response.data
        .map((json) => TrabajadorMapper.fromApiJson(json))
        .toList();
  }

  Future<List<Trabajador>> deleteTrabajadoresBatch(
    List<Trabajador> trabajadores,
  ) async {
    final response = await _client.post(
      '/trabajadores/delete-batch',
      data: trabajadores.map(TrabajadorMapper.toApiJson).toList(),
    );
    return response.data
        .map((json) => TrabajadorMapper.fromApiJson(json))
        .toList();
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
