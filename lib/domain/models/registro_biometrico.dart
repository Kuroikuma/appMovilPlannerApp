import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/database.dart';

import '../../data/converters/tipo_registro_biometrico.dart';

class RegistroBiometrico {
  final String id;
  final int trabajadorId;
  final List<double> datosBiometricos;
  final bool estado;
  final TipoRegistroBiometrico tipoRegistro;

  RegistroBiometrico({
    required this.id,
    required this.trabajadorId,
    this.estado = true,
    required this.datosBiometricos,
    required this.tipoRegistro,
  });

  factory RegistroBiometrico.fromJson(Map<String, dynamic> json) {
    return RegistroBiometrico(
      id: json['id'],
      trabajadorId: json['trabajadorId'],
      estado: json['estado'] ?? true,
      datosBiometricos: json['datosBiometricos'] as List<double>,
      tipoRegistro: TipoRegistroBiometrico.values.firstWhere(
        (element) => element.name == json['tipoRegistro'],
      ),
    );
  }

  factory RegistroBiometrico.fromDataModel(RegistrosBiometrico data) {
    return RegistroBiometrico(
      id: data.id,
      trabajadorId: data.trabajadorId,
      estado: data.estado,
      datosBiometricos: data.datosBiometricos,
      tipoRegistro: TipoRegistroBiometrico.values.firstWhere(
        (element) => element.name == data.tipoRegistro.name,
      ),
    );
  }

  RegistrosBiometrico toDataModel() {
    return RegistrosBiometrico(
      id: id,
      trabajadorId: trabajadorId,
      datosBiometricos: datosBiometricos,
      estado: estado,
      tipoRegistro: tipoRegistro,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trabajadorId': trabajadorId,
      'estado': estado,
      'datosBiometricos': datosBiometricos,
      'tipoRegistro': tipoRegistro.name,
    };
  }
}
