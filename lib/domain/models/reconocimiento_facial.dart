class ReconocimientoFacial {
  final String id;
  final String trabajadorId;
  final String imagenUrl;
  final double confianza;
  final DateTime fechaCreacion;
  final bool activo;

  ReconocimientoFacial({
    required this.id,
    required this.trabajadorId,
    required this.imagenUrl,
    required this.confianza,
    required this.fechaCreacion,
    this.activo = true,
  });

  factory ReconocimientoFacial.fromJson(Map<String, dynamic> json) {
    return ReconocimientoFacial(
      id: json['id'],
      trabajadorId: json['trabajadorId'],
      imagenUrl: json['imagenUrl'],
      confianza: json['confianza'].toDouble(),
      fechaCreacion: DateTime.parse(json['fechaCreacion']),
      activo: json['activo'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trabajadorId': trabajadorId,
      'imagenUrl': imagenUrl,
      'confianza': confianza,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'activo': activo,
    };
  }
}
