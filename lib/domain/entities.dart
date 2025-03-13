// Enumerado para el método de prueba de vida
enum MetodoPruebaVida { face, huella, otro }

class Trabajador {
  final int id;
  final String nombre;
  final String apellido;
  final String cedula;
  final bool activo;
  final DateTime? ultimaActualizacion;

  Trabajador({
    this.id = 0,
    required this.nombre,
    required this.apellido,
    required this.cedula,
    this.activo = true,
    this.ultimaActualizacion,
  });

  Trabajador copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? cedula,
    bool? activo,
    DateTime? ultimaActualizacion,
  }) {
    return Trabajador(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      cedula: cedula ?? this.cedula,
      activo: activo ?? this.activo,
      ultimaActualizacion: ultimaActualizacion ?? this.ultimaActualizacion,
    );
  }
}

class GrupoUbicaciones {
  final int id;
  final String nombre;

  GrupoUbicaciones({required this.id, required this.nombre});
}

class Ubicacion {
  final int id;
  final String nombre;
  final Map<String, dynamic> disponibilidad;
  final String grupoId;

  Ubicacion({
    required this.id,
    required this.nombre,
    required this.disponibilidad,
    required this.grupoId,
  });
}

class Horario {
  final int id;
  final String ubicacionId;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final Duration horaInicio;
  final Duration horaFin;

  Horario({
    required this.id,
    required this.ubicacionId,
    required this.fechaInicio,
    required this.fechaFin,
    required this.horaInicio,
    required this.horaFin,
  });
}

class RegistroBiometrico {
  final int id;
  final String trabajadorId;
  final String foto;
  final Map<String, dynamic> datosBiometricos;
  final bool pruebaVidaExitosa;
  final MetodoPruebaVida metodoPruebaVida;
  final double puntajeConfianza;

  RegistroBiometrico({
    required this.id,
    required this.trabajadorId,
    required this.foto,
    required this.datosBiometricos,
    required this.pruebaVidaExitosa,
    required this.metodoPruebaVida,
    required this.puntajeConfianza,
  });
}

class RegistroDiario {
  final int id;
  final String trabajadorId;
  final String registroBiometricoId;
  final DateTime fechaIngreso;
  final Duration horaIngreso;
  final DateTime? fechaSalida;
  final Duration? horaSalida;
  final bool ingresofonconizado;
  final bool salidaforconizada;

  RegistroDiario({
    required this.id,
    required this.trabajadorId,
    required this.registroBiometricoId,
    required this.fechaIngreso,
    required this.horaIngreso,
    this.fechaSalida,
    this.horaSalida,
    required this.ingresofonconizado,
    required this.salidaforconizada,
  });
}

class SyncEntityD {
  final int id;
  final String entityTableNameToSync;
  final String action; // 'CREATE', 'UPDATE', 'DELETE'
  final String registerId;
  final DateTime timestamp;

  SyncEntityD({
    required this.id,
    required this.entityTableNameToSync,
    required this.action,
    required this.registerId,
    required this.timestamp,
  });
}
