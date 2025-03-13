import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/domain/entities.dart';

class TrabajadorMapper {
  static Trabajador fromDataModel(Trabajadore data) {
    return Trabajador(
      id: data.id,
      nombre: data.nombre,
      apellido: data.apellido,
      cedula: data.cedula,
      activo: data.activo,
      ultimaActualizacion: data.ultimaActualizacion,
    );
  }

  static TrabajadoresCompanion toDataModel(Trabajador entity) {
    return TrabajadoresCompanion(
      id: Value(entity.id),
      nombre: Value(entity.nombre),
      apellido: Value(entity.apellido),
      cedula: Value(entity.cedula),
      activo: Value(entity.activo),
      ultimaActualizacion: Value(entity.ultimaActualizacion),
    );
  }

  static Trabajador fromApiJson(Map<String, dynamic> json) {
    return Trabajador(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      cedula: json['cedula'],
      activo: json['activo'],
      ultimaActualizacion: DateTime.parse(json['ultima_actualizacion']),
    );
  }

  static Map<String, dynamic> toApiJson(Trabajador entity) {
    return {
      'nombre': entity.nombre,
      'apellido': entity.apellido,
      'cedula': entity.cedula,
      'activo': entity.activo,
    };
  }
}

// Crear mappers similares para cada entidad
