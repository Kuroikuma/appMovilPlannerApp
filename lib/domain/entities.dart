// Enumerado para el método de prueba de vida
import 'package:flutter/material.dart';

import '../data/converters/action_sync.dart';

class Trabajador {
  final int id;
  final String nombre;
  final String primerApellido;
  final String segundoApellido;
  final bool faceSync;
  final int equipoId;
  final bool estado;
  final String fotoUrl;
  final String cargo;
  final String identificacion;

  Trabajador({
    this.id = 0,
    required this.nombre,
    required this.primerApellido,
    required this.segundoApellido,
    required this.equipoId,
    this.faceSync = true,
    this.estado = true,
    required this.fotoUrl,
    required this.cargo,
    required this.identificacion,
  });

  Trabajador copyWith({
    int? id,
    String? nombre,
    String? primerApellido,
    String? segundoApellido,
    bool? faceSync,
    int? equipoId,
    bool? estado,
    String? fotoUrl,
    String? cargo,
    String? identificacion,
  }) {
    return Trabajador(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      primerApellido: primerApellido ?? this.primerApellido,
      segundoApellido: segundoApellido ?? this.segundoApellido,
      equipoId: equipoId ?? this.equipoId,
      faceSync: faceSync ?? this.faceSync,
      estado: estado ?? this.estado,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      cargo: cargo ?? this.cargo,
      identificacion: identificacion ?? this.identificacion,
    );
  }
}

class GrupoUbicacion {
  final int id;
  final String nombre;
  final bool estado;

  GrupoUbicacion({required this.id, required this.nombre, this.estado = true});
}

class Ubicacion {
  final String id;
  final String nombre;
  final Map<String, dynamic> disponibilidad;
  final int grupoId;
  final bool estado;
  final int ubicacionId;

  Ubicacion({
    required this.id,
    required this.nombre,
    required this.disponibilidad,
    required this.grupoId,
    required this.ubicacionId,
    this.estado = true,
  });
}

class Horario {
  final int id;
  final int ubicacionId;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final TimeOfDay horaInicio;
  final TimeOfDay horaFin;
  final TimeOfDay inicioDescanso;
  final TimeOfDay finDescanso;
  final bool pagaAlmuerzo;
  final bool estado;

  Horario({
    required this.id,
    required this.ubicacionId,
    required this.fechaInicio,
    required this.fechaFin,
    required this.horaInicio,
    required this.horaFin,
    required this.inicioDescanso,
    required this.finDescanso,
    required this.pagaAlmuerzo,
    required this.estado,
  });
}

class SyncEntity {
  final int id;
  final String entityTableNameToSync;
  final TipoAccionesSync action; // 'CREATE', 'UPDATE', 'DELETE'
  final String registerId;
  final DateTime timestamp;
  final bool isSynced;
  final Map<String, dynamic> data;

  SyncEntity({
    required this.id,
    required this.entityTableNameToSync,
    required this.action,
    required this.registerId,
    required this.timestamp,
    required this.isSynced,
    required this.data,
  });
}
