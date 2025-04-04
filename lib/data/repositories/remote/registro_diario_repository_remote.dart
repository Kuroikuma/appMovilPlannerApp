import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/error/exceptions.dart';
import '../../../domain/models/registro_diario.dart';
import '../../../domain/repositories/i_registro_diario_repository.dart';
import 'api_client.dart';

class RegistroDiarioRepositoryRemote implements IRegistroDiarioRepository {
  final ApiClient _client;

  RegistroDiarioRepositoryRemote(this._client);

  // Datos de ejemplo para demostración
  final List<RegistroDiario> _registrosDemo = [
    RegistroDiario(
      id: 1,
      equipoId: 1,
      registroBiometricoId: 'bio123',
      fechaIngreso: DateTime.now().subtract(const Duration(days: 1)),
      horaIngreso: const TimeOfDay(hour: 8, minute: 0),
      fechaSalida: DateTime.now().subtract(const Duration(days: 1)),
      horaSalida: const TimeOfDay(hour: 17, minute: 30),
      estado: true,
      nombreTrabajador: 'Juan Pérez',
      fotoTrabajador: 'https://randomuser.me/api/portraits/men/1.jpg',
      cargoTrabajador: 'Desarrollador Senior',
    ),
    RegistroDiario(
      id: 2,
      equipoId: 2,
      registroBiometricoId: 'bio124',
      fechaIngreso: DateTime.now().subtract(const Duration(days: 1)),
      horaIngreso: const TimeOfDay(hour: 8, minute: 15),
      fechaSalida: DateTime.now().subtract(const Duration(days: 1)),
      horaSalida: const TimeOfDay(hour: 16, minute: 45),
      estado: true,
      nombreTrabajador: 'María González',
      fotoTrabajador: 'https://randomuser.me/api/portraits/women/2.jpg',
      cargoTrabajador: 'Diseñadora UX/UI',
    ),
    RegistroDiario(
      id: 3,
      equipoId: 3,
      registroBiometricoId: 'bio125',
      fechaIngreso: DateTime.now().subtract(const Duration(days: 1)),
      horaIngreso: const TimeOfDay(hour: 9, minute: 0),
      fechaSalida: DateTime.now().subtract(const Duration(days: 1)),
      horaSalida: const TimeOfDay(hour: 18, minute: 0),
      estado: false,
      nombreTrabajador: 'Carlos Rodríguez',
      fotoTrabajador: 'https://randomuser.me/api/portraits/men/3.jpg',
      cargoTrabajador: 'Gerente de Proyecto',
    ),
    RegistroDiario(
      id: 4,
      equipoId: 1,
      registroBiometricoId: 'bio126',
      fechaIngreso: DateTime.now(),
      horaIngreso: const TimeOfDay(hour: 8, minute: 5),
      estado: true,
      nombreTrabajador: 'Juan Pérez',
      fotoTrabajador: 'https://randomuser.me/api/portraits/men/1.jpg',
      cargoTrabajador: 'Desarrollador Senior',
    ),
    RegistroDiario(
      id: 5,
      equipoId: 4,
      registroBiometricoId: 'bio127',
      fechaIngreso: DateTime.now(),
      horaIngreso: const TimeOfDay(hour: 8, minute: 30),
      estado: true,
      nombreTrabajador: 'Ana Martínez',
      fotoTrabajador: 'https://randomuser.me/api/portraits/women/4.jpg',
      cargoTrabajador: 'Analista de Datos',
    ),
    RegistroDiario(
      id: 9,
      equipoId: 1,
      registroBiometricoId: 'bio133',
      fechaIngreso: DateTime.now().subtract(const Duration(days: 3)),
      horaIngreso: const TimeOfDay(hour: 8, minute: 0),
      fechaSalida: DateTime.now().subtract(const Duration(days: 3)),
      horaSalida: const TimeOfDay(hour: 17, minute: 0),
      estado: true,
      nombreTrabajador: 'Juan Pérez',
      fotoTrabajador: 'https://randomuser.me/api/portraits/men/1.jpg',
      cargoTrabajador: 'Desarrollador Senior',
    ),
    RegistroDiario(
      id: 10,
      equipoId: 2,
      registroBiometricoId: 'bio134',
      fechaIngreso: DateTime.now().subtract(const Duration(days: 4)),
      horaIngreso: const TimeOfDay(hour: 8, minute: 15),
      fechaSalida: DateTime.now().subtract(const Duration(days: 4)),
      horaSalida: const TimeOfDay(hour: 16, minute: 45),
      estado: true,
      nombreTrabajador: 'María González',
      fotoTrabajador: 'https://randomuser.me/api/portraits/women/2.jpg',
      cargoTrabajador: 'Diseñadora UX/UI',
    ),
    RegistroDiario(
      id: 11,
      equipoId: 3,
      registroBiometricoId: 'bio135',
      fechaIngreso: DateTime.now().subtract(const Duration(days: 5)),
      horaIngreso: const TimeOfDay(hour: 9, minute: 0),
      fechaSalida: DateTime.now().subtract(const Duration(days: 5)),
      horaSalida: const TimeOfDay(hour: 18, minute: 0),
      estado: true,
      nombreTrabajador: 'Carlos Rodríguez',
      fotoTrabajador: 'https://randomuser.me/api/portraits/men/3.jpg',
      cargoTrabajador: 'Gerente de Proyecto',
    ),
  ];

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

  @override
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
      return _registrosDemo;
    }

    return registrosDiarios.where((registro) {
      return registro.fechaIngreso.year == fecha.year &&
          registro.fechaIngreso.month == fecha.month &&
          registro.fechaIngreso.day == fecha.day;
    }).toList();
  }

  @override
  Future<RegistroDiario?> obtenerRegistroPorId(int id) async {
    // Simular una llamada a la API
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      return _registrosDemo.firstWhere((registro) => registro.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<RegistroDiario> registrarEntrada(
    int equipoId, {
    String? registroBiometricoId,
  }) async {
    // Simular una llamada a la API
    await Future.delayed(const Duration(milliseconds: 800));

    // Buscar información del trabajador
    final trabajador = _registrosDemo.firstWhere(
      (registro) => registro.equipoId == equipoId,
      orElse:
          () => RegistroDiario(
            equipoId: equipoId,
            fechaIngreso: DateTime.now(),
            horaIngreso: TimeOfDay.now(),
            nombreTrabajador: 'Trabajador #$equipoId',
          ),
    );

    // Crear nuevo registro
    final nuevoRegistro = RegistroDiario(
      id: _registrosDemo.length + 1,
      equipoId: equipoId,
      registroBiometricoId: registroBiometricoId,
      fechaIngreso: DateTime.now(),
      horaIngreso: TimeOfDay.now(),
      estado: true,
      nombreTrabajador: trabajador.nombreTrabajador,
      fotoTrabajador: trabajador.fotoTrabajador,
      cargoTrabajador: trabajador.cargoTrabajador,
    );

    // En una implementación real, aquí se guardaría en la base de datos
    _registrosDemo.add(nuevoRegistro);

    return nuevoRegistro;
  }

  @override
  Future<RegistroDiario> registrarSalida(
    int registroId, {
    String? registroBiometricoId,
  }) async {
    // Simular una llamada a la API
    await Future.delayed(const Duration(milliseconds: 800));

    // Buscar el registro
    final index = _registrosDemo.indexWhere(
      (registro) => registro.id == registroId,
    );
    if (index == -1) {
      throw Exception('Registro no encontrado');
    }

    // Actualizar el registro con la salida
    final registroActualizado = _registrosDemo[index].copyWith(
      fechaSalida: DateTime.now(),
      horaSalida: TimeOfDay.now(),
      registroBiometricoId:
          registroBiometricoId ?? _registrosDemo[index].registroBiometricoId,
    );

    // En una implementación real, aquí se actualizaría en la base de datos
    _registrosDemo[index] = registroActualizado;

    return registroActualizado;
  }

  @override
  Future<List<RegistroDiario>> obtenerRegistrosPorTrabajador(
    int equipoId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    // Simular una llamada a la API
    await Future.delayed(const Duration(seconds: 1));

    return _registrosDemo.where((registro) {
      bool cumpleFiltroTrabajador = registro.equipoId == equipoId;

      if (!cumpleFiltroTrabajador) return false;

      if (fechaInicio != null && fechaFin != null) {
        return registro.fechaIngreso.isAfter(
              fechaInicio.subtract(const Duration(days: 1)),
            ) &&
            registro.fechaIngreso.isBefore(
              fechaFin.add(const Duration(days: 1)),
            );
      }

      return true;
    }).toList();
  }

  @override
  Future<void> cambiarEstadoRegistro(int registroId, bool estado) async {
    // Simular una llamada a la API
    await Future.delayed(const Duration(milliseconds: 800));

    // Buscar el registro
    final index = _registrosDemo.indexWhere(
      (registro) => registro.id == registroId,
    );
    if (index == -1) {
      throw Exception('Registro no encontrado');
    }

    // Actualizar el estado
    _registrosDemo[index] = _registrosDemo[index].copyWith(estado: estado);

    // En una implementación real, aquí se actualizaría en la base de datos
  }

  @override
  Future<List<RegistroDiario>> obtenerRegistrosPorRangoFechas(
    String ubicacionId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    print(fechaInicio);
    print(fechaFin);

    // Simular una llamada a la API
    final registrosDiarios = await getRegistroDiarioPorUbicacion(
      ubicacionId,
      fechaInicio,
      fechaFin,
    );

    if (fechaInicio == null && fechaFin == null) {
      return _registrosDemo;
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
