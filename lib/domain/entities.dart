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
  final bool? isEntry;

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
    this.isEntry = false,
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
    bool? isEntry,
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
      isEntry: isEntry ?? this.isEntry,
    );
  }

  String get nombreCompleto {
    return '$nombre $primerApellido $segundoApellido';
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

class SyncEntity {
  final String id;
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
