import '../../data/converters/tipo_registro_biometrico.dart';

class ReconocimientoFacial {
  final String id;
  final String trabajadorId;
  final String imagenUrl;
  final double puntajeConfianza;
  final DateTime fechaCreacion;
  final bool estado;
  final bool pruebaVidaExitosa;
  final TipoRegistroBiometrico metodoPruebaVida;

  ReconocimientoFacial({
    required this.id,
    required this.trabajadorId,
    required this.imagenUrl,
    required this.puntajeConfianza,
    required this.fechaCreacion,
    this.estado = true,
    required this.pruebaVidaExitosa,
    required this.metodoPruebaVida,
  });

  factory ReconocimientoFacial.fromJson(Map<String, dynamic> json) {
    return ReconocimientoFacial(
      id: json['id'],
      trabajadorId: json['trabajadorId'],
      imagenUrl: json['imagenUrl'],
      puntajeConfianza: json['puntajeConfianza'].toDouble(),
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
      estado: json['estado'] ?? true,
      pruebaVidaExitosa: json['pruebaVidaExitosa'] ?? false,
      metodoPruebaVida: TipoRegistroBiometrico.values.firstWhere(
        (element) => element.name == json['metodoPruebaVida'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trabajadorId': trabajadorId,
      'imagenUrl': imagenUrl,
      'puntajeConfianza': puntajeConfianza,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'estado': estado,
      'pruebaVidaExitosa': pruebaVidaExitosa,
      'metodoPruebaVida': metodoPruebaVida.name,
    };
  }
}
