import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'converters/json_converter.dart';
import 'converters/time_converter.dart';
import 'converters/date_converter.dart';
import 'converters/metodo_prueba_vida.dart';

part 'database.g.dart';

Uuid uuid = const Uuid();

@DriftDatabase(
  tables: [
    Trabajadores,
    GrupoUbicaciones,
    Ubicaciones,
    Horarios,
    RegistroBiometrico,
    RegistroDiario,
    SyncEntitys,
    Equipo,
    LiderUbicaciones,
    CargosLiderazgo,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll(); // Crea todas las tablas

      // Inserta registros iniciales
      await into(trabajadores).insert(
        TrabajadoresCompanion.insert(
          nombre: 'Juan',
          apellido: 'Pérez',
          cedula: '1234567890',
          activo: Value(true),
          ultimaActualizacion: Value(DateTime.now()),
        ),
      );

      await into(trabajadores).insert(
        TrabajadoresCompanion.insert(
          nombre: 'María',
          apellido: 'López',
          cedula: '0987654321',
          activo: Value(true),
          ultimaActualizacion: Value(DateTime.now()),
        ),
      );
    },
  );
}

// Tabla: Trabajadores
class Trabajadores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get apellido => text()();
  TextColumn get cedula => text().unique()();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get ultimaActualizacion => dateTime().nullable()();
}

class Equipo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get liderUbicacionId => text().references(LiderUbicaciones, #id)();
  TextColumn get trabajadorId => text().references(Trabajadores, #id)();
  TextColumn get idRegistro => text().references(Trabajadores, #id)();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
}

@DataClassName("LiderUbicacion")
class LiderUbicaciones extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get ubicacionId => text().references(Ubicaciones, #id)();
  TextColumn get liderId => text().references(Trabajadores, #id)();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  TextColumn get cargoLiderazgoId => text().references(CargosLiderazgo, #id)();
}

@DataClassName("CargoLiderazgo")
class CargosLiderazgo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get nombre => text().withLength(min: 1, max: 50)();
  TextColumn get observacion => text().withLength(max: 300).nullable()();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
}

// Tabla: GrupoUbicaciones
class GrupoUbicaciones extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
}

// Tabla: Ubicaciones
class Ubicaciones extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get disponibilidad => text().map(const JsonConverter())();
  TextColumn get grupoId => text().references(GrupoUbicaciones, #id)();
}

class Horario {
  final int id;
  final String ubicacionId;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final TimeOfDay horaInicio;
  final TimeOfDay horaFin;

  Horario({
    required this.id,
    required this.ubicacionId,
    required this.fechaInicio,
    required this.fechaFin,
    required this.horaInicio,
    required this.horaFin,
  });
}

// Tabla: Horarios
@UseRowClass(Horario)
class Horarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ubicacionId => text().references(Ubicaciones, #id)();
  TextColumn get fechaInicio => text().map(const DateConverter())();
  TextColumn get fechaFin => text().map(const DateConverter())();
  TextColumn get horaInicio => text().map(const TimeOfDayConverter())();
  TextColumn get horaFin => text().map(const TimeOfDayConverter())();
}

// Tabla: RegistroBiometrico
class RegistroBiometrico extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get trabajadorId => text().references(Trabajadores, #id)();
  TextColumn get foto => text()();
  TextColumn get datosBiometricos => text().map(const JsonConverter())();
  BoolColumn get pruebaVidaExitosa => boolean()();
  TextColumn get metodoPruebaVida =>
      text().map(const MetodoPruebaVidaConverter())();
  RealColumn get puntajeConfianza => real()();
}

// Tabla: RegistroDiario
class RegistroDiario extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get equipoId => text().references(Equipo, #id)();
  TextColumn get registroBiometricoId =>
      text().references(RegistroBiometrico, #id)();
  TextColumn get fechaIngreso => text().map(const DateConverter())();
  TextColumn get horaIngreso => text().map(const TimeOfDayConverter())();
  TextColumn get fechaSalida => text().map(const DateConverter())();
  TextColumn get horaSalida => text().map(const TimeOfDayConverter())();
  BoolColumn get ingresoSincronizado => boolean()();
  BoolColumn get salidaSincronizada => boolean()();
}

class SyncEntitys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityTableNameToSync => text()();
  TextColumn get action => text()();
  TextColumn get registerId => text()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}
