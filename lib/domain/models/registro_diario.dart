import 'package:flutter/material.dart';

class RegistroDiario {
  final int? id;
  final int equipoId;
  final String? registroBiometricoId;
  final DateTime fechaIngreso;
  final TimeOfDay horaIngreso;
  final DateTime? fechaSalida;
  final TimeOfDay? horaSalida;
  final bool estado;

  // Campos adicionales para la UI
  final String? nombreTrabajador;
  final String? fotoTrabajador;
  final String? cargoTrabajador;

  RegistroDiario({
    this.id,
    required this.equipoId,
    this.registroBiometricoId,
    required this.fechaIngreso,
    required this.horaIngreso,
    this.fechaSalida,
    this.horaSalida,
    this.estado = true,
    this.nombreTrabajador,
    this.fotoTrabajador,
    this.cargoTrabajador,
  });

  // Verificar si el registro tiene salida registrada
  bool get tieneSalida => fechaSalida != null && horaSalida != null;

  // Calcular la duración del registro (si tiene entrada y salida)
  Duration? get duracion {
    if (!tieneSalida) return null;

    final entrada = DateTime(
      fechaIngreso.year,
      fechaIngreso.month,
      fechaIngreso.day,
      horaIngreso.hour,
      horaIngreso.minute,
    );

    final salida = DateTime(
      fechaSalida!.year,
      fechaSalida!.month,
      fechaSalida!.day,
      horaSalida!.hour,
      horaSalida!.minute,
    );

    return salida.difference(entrada);
  }

  // Formatear la duración como string
  String get duracionFormateada {
    final d = duracion;
    if (d == null) return 'En curso';

    final horas = d.inHours;
    final minutos = d.inMinutes.remainder(60);

    return '$horas h $minutos min';
  }

  // Crear una copia del objeto con algunos campos modificados
  RegistroDiario copyWith({
    int? id,
    int? equipoId,
    String? registroBiometricoId,
    DateTime? fechaIngreso,
    TimeOfDay? horaIngreso,
    DateTime? fechaSalida,
    TimeOfDay? horaSalida,
    bool? estado,
    String? nombreTrabajador,
    String? fotoTrabajador,
    String? cargoTrabajador,
  }) {
    return RegistroDiario(
      id: id ?? this.id,
      equipoId: equipoId ?? this.equipoId,
      registroBiometricoId: registroBiometricoId ?? this.registroBiometricoId,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      horaIngreso: horaIngreso ?? this.horaIngreso,
      fechaSalida: fechaSalida ?? this.fechaSalida,
      horaSalida: horaSalida ?? this.horaSalida,
      estado: estado ?? this.estado,
      nombreTrabajador: nombreTrabajador ?? this.nombreTrabajador,
      fotoTrabajador: fotoTrabajador ?? this.fotoTrabajador,
      cargoTrabajador: cargoTrabajador ?? this.cargoTrabajador,
    );
  }

  // Crear un objeto desde un mapa (JSON)
  factory RegistroDiario.fromJson(Map<String, dynamic> json) {
    return RegistroDiario(
      id: json['id'],
      equipoId: json['equipoId'],
      registroBiometricoId: json['registroBiometricoId'],
      fechaIngreso: DateTime.parse(json['fechaIngreso']),
      horaIngreso: _timeFromString(json['horaIngreso']),
      fechaSalida:
          json['fechaSalida'] != null
              ? DateTime.parse(json['fechaSalida'])
              : null,
      horaSalida:
          json['horaSalida'] != null
              ? _timeFromString(json['horaSalida'])
              : null,
      estado: json['estado'] ?? true,
      nombreTrabajador: json['nombreTrabajador'],
      fotoTrabajador: json['fotoTrabajador'],
      cargoTrabajador: json['cargoTrabajador'],
    );
  }

  // Convertir el objeto a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'equipoId': equipoId,
      'registroBiometricoId': registroBiometricoId,
      'fechaIngreso': fechaIngreso.toIso8601String(),
      'horaIngreso': '${horaIngreso.hour}:${horaIngreso.minute}',
      'fechaSalida': fechaSalida?.toIso8601String(),
      'horaSalida':
          horaSalida != null
              ? '${horaSalida!.hour}:${horaSalida!.minute}'
              : null,
      'estado': estado,
      'nombreTrabajador': nombreTrabajador,
      'fotoTrabajador': fotoTrabajador,
      'cargoTrabajador': cargoTrabajador,
    };
  }

  // Convertir string de hora a TimeOfDay
  static TimeOfDay _timeFromString(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
