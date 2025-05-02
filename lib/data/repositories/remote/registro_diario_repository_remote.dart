import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/converters/time_converter.dart';
import '../../../core/error/exceptions.dart';
import '../../../domain/models/registro_diario.dart';
import 'api_client.dart';

class RegistroDiarioRepositoryRemote {
  final ApiClient _client;

  RegistroDiarioRepositoryRemote(this._client);

  Future<List<RegistroDiario>> getRegistroDiarioPorUbicacion(
    String ubicacionId,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  ) async {
    try {
      // Simular una llamada a la API
      final response = await _client.get(
        '/GetListRegistroDiarioByUbicacionId?ubicacionId=$ubicacionId',
        queryParameters: {
          'fechaInicio':
              '${fechaInicio?.year}-${fechaInicio?.month}-${fechaInicio?.day}',
          'fechaFin': '${fechaFin?.year}-${fechaFin?.month}-${fechaFin?.day}',
        },
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
          return RegistroDiario.fromJson(json);
        } catch (e) {
          rethrow;
        }
      }).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException();
      }
      throw ApiException();
    }
  }

  Future<List<RegistroDiario>> obtenerRegistrosPorUbicacion(
    String ubicacionId, {
    DateTime? fecha,
  }) async {
    // Simular una llamada a la API
    final registrosDiarios = await getRegistroDiarioPorUbicacion(
      ubicacionId,
      fecha,
      fecha,
    );

    if (fecha == null) {
      return [];
    }

    return registrosDiarios.where((registro) {
      return registro.fechaIngreso.year == fecha.year &&
          registro.fechaIngreso.month == fecha.month &&
          registro.fechaIngreso.day == fecha.day;
    }).toList();
  }


  Future<RegistroDiario> registrarAsistencia(
    int equipoId,
    int horaAprobadaId,
    bool isEntry,
    DateTime? fechaIngreso,
    TimeOfDay? horaIngreso,
    int? registroDiarioId,
  ) async {

    // Simular una llamada a la API

    final Map<String, dynamic> data = {
      'horaAprobadaId': horaAprobadaId,
      'equipoId': equipoId,
    };

    if (isEntry == true) {
      data['fechaSalida'] = DateTime.now();
      data['horaSalida'] = TimeOfDayConverter().toSql(TimeOfDay.now());
      data['fechaIngreso'] = fechaIngreso;
      data['horaIngreso'] = TimeOfDayConverter().toSql(horaIngreso!);
      data['registroDiarioId'] = registroDiarioId;
    } else {
      data['fechaIngreso'] = DateTime.now();
      data['horaIngreso'] = TimeOfDayConverter().toSql(TimeOfDay.now());
    }
    
    final nuevoRegistroFormData = FormData.fromMap(data);


     final response = isEntry
      ? await _client.put(
          '/UpdateRegistroDiarioByLocal',
          data: nuevoRegistroFormData,
        )
      : await _client.post(
          '/PostSaveRegistroDiarioByLocal',
          data: nuevoRegistroFormData,
        );

    return RegistroDiario.fromJson(response.data);
  }

  Future<void> insertarRegistroDiario(
    Map<String, dynamic> registroDiario,
  ) async {

  final nuevoRegistroFormData = FormData.fromMap(registroDiario);

    // Simular una llamada a la API
    final nuevoRegistro = await _client.post(
      '/PostSaveRegistroDiarioByLocal',
      data: nuevoRegistroFormData,
    );

    if (nuevoRegistro.statusCode != 200) {
      throw ApiException();
    }
  }



  Future<List<RegistroDiario>> obtenerRegistrosPorRangoFechas(
    String ubicacionId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
   

    // Simular una llamada a la API
    final registrosDiarios = await getRegistroDiarioPorUbicacion(
      ubicacionId,
      fechaInicio,
      fechaFin,
    );

    if (fechaInicio == null && fechaFin == null) {
      return [];
    }

    return registrosDiarios.where((registro) {
      final fecha = registro.fechaIngreso;

      if (fechaInicio != null && fechaFin != null) {
        // Normalizar fechas para comparación (sin hora)
        final inicio = DateTime(
          fechaInicio.year,
          fechaInicio.month,
          fechaInicio.day,
        );
        final fin = DateTime(fechaFin.year, fechaFin.month, fechaFin.day);
        final registroFecha = DateTime(fecha.year, fecha.month, fecha.day);

        return registroFecha.isAtSameMomentAs(inicio) ||
            registroFecha.isAtSameMomentAs(fin) ||
            (registroFecha.isAfter(inicio) && registroFecha.isBefore(fin));
      } else if (fechaInicio != null) {
        final inicio = DateTime(
          fechaInicio.year,
          fechaInicio.month,
          fechaInicio.day,
        );
        final registroFecha = DateTime(fecha.year, fecha.month, fecha.day);
        return registroFecha.isAtSameMomentAs(inicio) ||
            registroFecha.isAfter(inicio);
      } else if (fechaFin != null) {
        final fin = DateTime(fechaFin.year, fechaFin.month, fechaFin.day);
        final registroFecha = DateTime(fecha.year, fecha.month, fecha.day);
        return registroFecha.isAtSameMomentAs(fin) ||
            registroFecha.isBefore(fin);
      }

      return true;
    }).toList();
  }
}
