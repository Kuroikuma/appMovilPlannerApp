import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'converters/action_sync.dart';
import 'converters/json_converter.dart';
import 'converters/json_converter_embedding.dart';
import 'converters/time_converter.dart';
import 'converters/date_converter.dart';
import 'converters/tipo_registro_biometrico.dart';

part 'database.g.dart';

Uuid uuid = const Uuid();

@DriftDatabase(
  tables: [
    Trabajadores,
    GruposUbicaciones,
    Ubicaciones,
    Horarios,
    RegistrosBiometricos,
    RegistrosDiarios,
    SyncsEntitys,
    ReconocimientosFacial,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  // @override
  // MigrationStrategy get migration => MigrationStrategy(
  //   onCreate: (m) async {
  //     await m.createAll(); // Crea todas las tablas

  //     // Inserta registros iniciales
  //     await into(trabajadores).insert(
  //       TrabajadoresCompanion.insert(
  //         nombre: 'Juan',
  //         apellido: 'Pérez',
  //         cedula: '1234567890',
  //         activo: Value(true),
  //         ultimaActualizacion: Value(DateTime.now()),
  //       ),
  //     );

  //     await into(trabajadores).insert(
  //       TrabajadoresCompanion.insert(
  //         nombre: 'María',
  //         apellido: 'López',
  //         cedula: '0987654321',
  //         activo: Value(true),
  //         ultimaActualizacion: Value(DateTime.now()),
  //       ),
  //     );
  //   },
  // );
}

// Tabla: Trabajadores
class Trabajadores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get primerApellido => text().named('primer_apellido')();
  TextColumn get segundoApellido => text().named('segundo_apellido')();
  IntColumn get equipoId => integer().unique().named('equipo_id')();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  BoolColumn get faceSync =>
      boolean().withDefault(const Constant(false)).named('face_sync')();
  TextColumn get fotoUrl => text().named('foto_url')();
  TextColumn get cargo => text().named('cargo')();
  TextColumn get identificacion => text().named('identificacion')();
}

// Tabla: GrupoUbicaciones
class GruposUbicaciones extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
}

// Tabla: Ubicaciones
class Ubicaciones extends Table {
  TextColumn get id => text().unique()();
  TextColumn get nombre => text()();
  IntColumn get ubicacionId => integer().unique().named('ubicacion_id')();
  // TextColumn get grupoId => text().references(GruposUbicaciones, #id)();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  IntColumn get codigoUbicacion =>
      integer().unique().named('codigo_ubicacion')();
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

// Tabla: Horarios
@UseRowClass(Horario)
class Horarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ubicacionId =>
      integer().references(Ubicaciones, #ubicacionId)();
  TextColumn get fechaInicio => text().map(const DateConverter())();
  TextColumn get fechaFin => text().map(const DateConverter())();
  TextColumn get horaInicio => text().map(const TimeOfDayConverter())();
  TextColumn get horaFin => text().map(const TimeOfDayConverter())();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  BoolColumn get pagaAlmuerzo => boolean().withDefault(const Constant(false))();
  TextColumn get inicioDescanso => text().map(const TimeOfDayConverter())();
  TextColumn get finDescanso => text().map(const TimeOfDayConverter())();
}

// Tabla: RegistroBiometrico
class RegistrosBiometricos extends Table {
  TextColumn get id => text()();
  IntColumn get trabajadorId =>
      integer().named('trabajador_id').references(Trabajadores, #id)();
  TextColumn get datosBiometricos =>
      text().named('datos_biometricos').map(const JsonConverterEmbedding())();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  TextColumn get tipoRegistro =>
      text()
          .named('tipo_registro')
          .map(const TipoRegistroBiometricoConverter())();
}

class ReconocimientosFacial extends Table {
  TextColumn get id => text()();
  IntColumn get trabajadorId => integer().references(Trabajadores, #equipoId)();
  TextColumn get imagenUrl => text()();
  BoolColumn get pruebaVidaExitosa => boolean()();
  TextColumn get metodoPruebaVida =>
      text().map(const TipoRegistroBiometricoConverter())();
  RealColumn get puntajeConfianza => real()();
  TextColumn get fechaCreacion =>
      text().named('fecha_creacion').map(const DateConverter())();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
}

// Tabla: RegistroDiario
class RegistrosDiarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get equipoId =>
      integer().named('equipo_id').references(Trabajadores, #equipoId)();
  TextColumn get reconocimientoFacialId =>
      text()
          .nullable()
          .named('reconocimiento_facial_id')
          .references(ReconocimientosFacial, #id)();
  TextColumn get fechaIngreso =>
      text().named('fecha_ingreso').map(const DateConverter())();
  TextColumn get horaIngreso =>
      text().named('hora_ingreso').map(const TimeOfDayConverter())();
  TextColumn get fechaSalida =>
      text().named('fecha_salida').map(const DateConverter())();
  TextColumn get horaSalida =>
      text().named('hora_salida').map(const TimeOfDayConverter())();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  TextColumn get nombreTrabajador => text().named('nombre_trabajador')();
  TextColumn get fotoTrabajador => text().named('foto_trabajador')();
  TextColumn get cargoTrabajador => text().named('cargo_trabajador')();
}

class SyncsEntitys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityTableNameToSync => text()();
  // TextColumn get action => text()();
  TextColumn get action => text().map(const TipoAccionesSyncConverter())();
  TextColumn get registerId => text()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  TextColumn get data => text().map(const JsonConverter())();
}
