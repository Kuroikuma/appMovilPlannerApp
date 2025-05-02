import 'package:flutter_application_1/data/database.dart';
import '../../data/converters/json_converter_embedding.dart';
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
    final registroBiometrico = RegistroBiometrico(
      id: json['id'],
      trabajadorId: json['trabajadorId'],
      estado: json['estado'] ?? true,
      datosBiometricos: JsonConverterEmbedding().fromSql(
        json['datosBiometricos'],
      ),
      tipoRegistro: TipoRegistroBiometrico.values.firstWhere(
        (element) => element.index == json['tipoRegistro'],
      ),
    );
    return registroBiometrico;
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
