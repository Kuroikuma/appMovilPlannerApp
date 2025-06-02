import 'package:flutter/material.dart';

import '../../data/database.dart';

class RegistroDiario {
  final int? id;
  final int equipoId;
  final String? reconocimientoFacialId;
  final DateTime fechaIngreso;
  final TimeOfDay horaIngreso;
  final DateTime? fechaSalida;
  final TimeOfDay? horaSalida;
  final bool estado;
  final int horarioId;
  final int? registroId;
  final TimeOfDay? iniciaLabores;
  final TimeOfDay? finLabores;

  // Campos adicionales para la UI
  final String? nombreTrabajador;
  final String? fotoTrabajador;
  final String? cargoTrabajador;

  RegistroDiario({
    this.id,
    required this.equipoId,
    this.reconocimientoFacialId,
    required this.fechaIngreso,
    required this.horaIngreso,
    this.iniciaLabores,
    this.finLabores,
    this.fechaSalida,
    this.horaSalida,
    this.estado = true,
    this.nombreTrabajador,
    this.fotoTrabajador,
    this.cargoTrabajador,
    this.registroId,
    required this.horarioId,
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
    String? reconocimientoFacialId,
    DateTime? fechaIngreso,
    TimeOfDay? horaIngreso,
    DateTime? fechaSalida,
    TimeOfDay? horaSalida,
    bool? estado,
    String? nombreTrabajador,
    String? fotoTrabajador,
    String? cargoTrabajador,
    int? horarioId,
    int? registroId,
    TimeOfDay? iniciaLabores,
    TimeOfDay? finLabores,
  }) {
    return RegistroDiario(
      id: id ?? this.id,
      equipoId: equipoId ?? this.equipoId,
      reconocimientoFacialId:
          reconocimientoFacialId ?? this.reconocimientoFacialId,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      horaIngreso: horaIngreso ?? this.horaIngreso,
      fechaSalida: fechaSalida ?? this.fechaSalida,
      horaSalida: horaSalida ?? this.horaSalida,
      estado: estado ?? this.estado,
      nombreTrabajador: nombreTrabajador ?? this.nombreTrabajador,
      fotoTrabajador: fotoTrabajador ?? this.fotoTrabajador,
      cargoTrabajador: cargoTrabajador ?? this.cargoTrabajador,
      horarioId: horarioId ?? this.horarioId,
      registroId: registroId ?? this.registroId,
      iniciaLabores: iniciaLabores ?? this.iniciaLabores,
      finLabores: finLabores ?? this.finLabores,
    );
  }

  // Crear un objeto desde un mapa (JSON)
  factory RegistroDiario.fromJson(Map<String, dynamic> json) {
    return RegistroDiario(
      id: json['registroDiarioId'],
      equipoId: json['equipoId'],
      reconocimientoFacialId: json['reconocimientoFacialId'] ?? '',
      fechaIngreso: DateTime.parse(json['fechaIngreso']),
      horaIngreso: _timeFromString(json['horaIngreso']),
      fechaSalida:
          json['fechaSalida'] != "0001-01-01T00:00:00"
              ? DateTime.parse(json['fechaSalida'])
              : null,
      horaSalida:
          json['horaSalida'] != "00:00:00"
              ? _timeFromString(json['horaSalida'])
              : null,
      iniciaLabores:
          json['iniciaLabores'] != "00:00:00"
              ? json['iniciaLabores'] != null ? _timeFromString(json['iniciaLabores']) : null
              : null,
      finLabores:
          json['finLabores'] != "00:00:00"
              ? json['finLabores'] != null ? _timeFromString(json['finLabores']) : null
              : null,
      estado: json['estado'] ?? true,
      nombreTrabajador: json['trabajadorNombreCompleto'] ?? 'Desconocido',
      fotoTrabajador:
          json['trabajadorStringFile'] ??
          'https://randomuser.me/api/portraits/men/1.jpg',
      cargoTrabajador: json['puestoNombre'] ?? 'Desconocido',
      registroId: json['registroId'] ?? 0,
      horarioId: json['horaAprobadaId'],
    );
  }

  factory RegistroDiario.fromDataModel(RegistrosDiario data) {
    return RegistroDiario(
      id: data.id,
      equipoId: data.equipoId,
      fechaIngreso: data.fechaIngreso,
      horaIngreso: data.horaIngreso,
      fechaSalida: data.fechaSalida,
      horaSalida: data.horaSalida,
      estado: data.estado,
      nombreTrabajador: data.nombreTrabajador,
      fotoTrabajador: data.fotoTrabajador,
      cargoTrabajador: data.cargoTrabajador,
      horarioId: data.horarioId,
      registroId: data.registroId,
      reconocimientoFacialId: data.reconocimientoFacialId,
      iniciaLabores: data.iniciaLabores,
      finLabores: data.finLabores,
    );
  }

  // Convertir el objeto a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'equipoId': equipoId,
      'reconocimientoFacialId': reconocimientoFacialId,
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
      'horarioId': horarioId,
      'registroId': registroId,
      'iniciaLabores': iniciaLabores != null
          ? '${iniciaLabores!.hour}:${iniciaLabores!.minute}'
          : null,
      'finLabores': finLabores != null
          ? '${finLabores!.hour}:${finLabores!.minute}'
          : null,
    };
  }

  // Convertir string de hora a TimeOfDay
  static TimeOfDay _timeFromString(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  // Método para obtener el tiempo transcurrido desde el ingreso
  Duration get tiempoTranscurridoDesdeIngreso {
    final ahora = DateTime.now();

    // Convertir TimeOfDay a DateTime para cálculos precisos
    final fechaHoraIngreso = DateTime(
      fechaIngreso.year,
      fechaIngreso.month,
      fechaIngreso.day,
      iniciaLabores?.hour ?? 0,
      finLabores?.minute ?? 0,
    );

    return ahora.difference(fechaHoraIngreso);
  }

  Duration? get tiempoTranscurridoDesdeSalida {
    if (!tieneSalida) return null;

    final ahora = DateTime.now();

    // Convertir TimeOfDay a DateTime para cálculos precisos
    final fechaHoraSalida = DateTime(
      fechaSalida!.year,
      fechaSalida!.month,
      fechaSalida!.day,
      horaSalida!.hour,
      horaSalida!.minute,
    );

    return ahora.difference(fechaHoraSalida);
  }

  // Verificar si ha pasado el tiempo mínimo para registrar salida (5 minutos)
  bool get puedeRegistrarSalida {
    // Si ya tiene salida registrada, no puede registrar otra
    if (tieneSalida) return false;

    // Verificar si han pasado al menos 5 minutos desde el ingreso
    return tiempoTranscurridoDesdeIngreso.inMinutes >= 5;
  }

  // Obtener el tiempo restante antes de poder registrar salida
  Duration get tiempoRestanteParaSalida {
    final tiempoMinimo = const Duration(minutes: 5);
    final tiempoTranscurrido = tiempoTranscurridoDesdeIngreso;

    if (tiempoTranscurrido >= tiempoMinimo) {
      return Duration.zero;
    }

    return tiempoMinimo - tiempoTranscurrido;
  }

  // Formato legible del tiempo restante
  String get tiempoRestanteFormateado {
    final restante = tiempoRestanteParaSalida;

    if (restante.inSeconds <= 0) {
      return "Puede registrar salida";
    }

    final minutos = restante.inMinutes;
    final segundos = restante.inSeconds % 60;

    if (minutos > 0) {
      return "$minutos min $segundos seg";
    } else {
      return "$segundos segundos";
    }
  }
}
