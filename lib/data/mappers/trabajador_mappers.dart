import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/domain/entities.dart';

class TrabajadorMapper {
  static Trabajador fromDataModel(Trabajadore data) {
    return Trabajador(
      id: data.id,
      nombre: data.nombre,
      primerApellido: data.primerApellido,
      segundoApellido: data.segundoApellido,
      equipoId: data.equipoId,
      faceSync: data.estado,
      estado: data.estado,
      fotoUrl: data.fotoUrl,
      cargo: data.cargo,
      identificacion: data.identificacion,
    );
  }

  static TrabajadoresCompanion toDataModel(Trabajador entity) {
    return TrabajadoresCompanion(
      id: Value(entity.id),
      nombre: Value(entity.nombre),
      primerApellido: Value(entity.primerApellido),
      segundoApellido: Value(entity.segundoApellido),
      equipoId: Value(entity.equipoId),
      estado: Value(entity.faceSync),
      faceSync: Value(entity.faceSync),
      fotoUrl: Value(entity.fotoUrl),
      cargo: Value(entity.cargo),
      identificacion: Value(entity.identificacion),
    );
  }

  static Trabajador fromApiJson(Map<String, dynamic> json) {
    try {
      return Trabajador(
        id: json['trabajadorId'] ?? 0,
        nombre: json['nombre']?.toString() ?? '',
        primerApellido: json['primerApellido']?.toString() ?? '',
        segundoApellido: json['segundoApellido']?.toString() ?? '',
        equipoId: json['equipoId'] ?? 0,
        faceSync: json['faceSync'] ?? false,
        estado: json['estado'] ?? false,
        fotoUrl: json['stringImagen']?.toString() ?? '',
        cargo: json['puestoNombre']?.toString() ?? '',
        identificacion: json['identificacion']?.toString() ?? '',
      );
    } catch (e) {
      print('Error mapeando JSON: $e');
      print('JSON problemático: $json');
      rethrow;
    }
  }

  static Map<String, dynamic> toApiJson(Trabajador entity) {
    return {
      'nombre': entity.nombre,
      'primerApellido': entity.primerApellido,
      'segundoApellido': entity.segundoApellido,
      'equipoId': entity.equipoId,
      'faceSync': entity.faceSync,
      'estado': entity.estado,
      'fotoUrl': entity.fotoUrl,
      'cargo': entity.cargo,
    };
  }
}

// Crear mappers similares para cada entidad
