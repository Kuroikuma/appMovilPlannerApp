import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import '../../../domain/models/registro_diario.dart';
import '../../converters/date_converter.dart';
import '../../converters/time_converter.dart';
import '../../mappers/registro_diario_mapper.dart';

class RegistroDiarioRepositoryLocal {
  final AppDatabase _db;

  RegistroDiarioRepositoryLocal(this._db);

  Future<List<RegistroDiario>> getRegistroDiario() async {
    final result = await _db.select(_db.registrosDiarios).get();
    return result.map(RegistroDiario.fromDataModel).toList();
  }

  Future<List<RegistroDiario>> obtenerRegistrosPorUbicacion(
    String ubicacionId, {
    DateTime? fecha,
  }) async {
    // Simular una llamada a la API
    final registrosDiarios = await getRegistroDiario();

    if (fecha == null) {
      return registrosDiarios;
    }

    return registrosDiarios.where((registro) {
      return registro.fechaIngreso.year == fecha.year &&
          registro.fechaIngreso.month == fecha.month &&
          registro.fechaIngreso.day == fecha.day;
    }).toList();
  }

  Future<RegistroDiario?> obtenerRegistroPorId(int id) async {
    // Simular una llamada a la API
    final registrosDiarios = await getRegistroDiario();

    try {
      return registrosDiarios.firstWhere((registro) => registro.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<RegistroDiario>> obtenerRegistrosPorTrabajador(
    int equipoId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    // Simular una llamada a la API
    final registrosDiarios = await getRegistroDiario();

    return registrosDiarios.where((registro) {
      bool cumpleFiltroTrabajador = registro.equipoId == equipoId;

      if (!cumpleFiltroTrabajador) return false;

      if (fechaInicio != null && fechaFin != null) {
        return registro.fechaIngreso.isAfter(
              fechaInicio.subtract(const Duration(days: 1)),
            ) &&
            registro.fechaIngreso.isBefore(
              fechaFin.add(const Duration(days: 1)),
            );
      }

      return true;
    }).toList();
  }

  Future<List<RegistroDiario>> obtenerRegistrosPorRangoFechas(
    String ubicacionId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    // Simular una llamada a la API
    final registrosDiarios = await getRegistroDiario();

    if (fechaInicio == null && fechaFin == null) {
      return registrosDiarios;
    }

    return registrosDiarios.where((registro) {
      final fecha = registro.fechaIngreso;

      if (fechaInicio != null && fechaFin != null) {
        // Normalizar fechas para comparación (sin hora)
        final inicio = DateTime(
          fechaInicio.year,
          fechaInicio.month,
          fechaInicio.day,
        );
        final fin = DateTime(fechaFin.year, fechaFin.month, fechaFin.day);
        final registroFecha = DateTime(fecha.year, fecha.month, fecha.day);

        return registroFecha.isAtSameMomentAs(inicio) ||
            registroFecha.isAtSameMomentAs(fin) ||
            (registroFecha.isAfter(inicio) && registroFecha.isBefore(fin));
      } else if (fechaInicio != null) {
        final inicio = DateTime(
          fechaInicio.year,
          fechaInicio.month,
          fechaInicio.day,
        );
        final registroFecha = DateTime(fecha.year, fecha.month, fecha.day);
        return registroFecha.isAtSameMomentAs(inicio) ||
            registroFecha.isAfter(inicio);
      } else if (fechaFin != null) {
        final fin = DateTime(fechaFin.year, fechaFin.month, fechaFin.day);
        final registroFecha = DateTime(fecha.year, fecha.month, fecha.day);
        return registroFecha.isAtSameMomentAs(fin) ||
            registroFecha.isBefore(fin);
      }

      return true;
    }).toList();
  }

  Future<void> syncronizarRegistrosDiarios(
    List<RegistroDiario> registrosDiarios,
  ) async {
    try {
      await _db.batch((batch) {
        batch.deleteAll(_db.registrosDiarios);
        batch.insertAll(
          _db.registrosDiarios,
          registrosDiarios
              .map(
                (e) => RegistrosDiariosCompanion(
                  cargoTrabajador: Value(e.cargoTrabajador!),
                  fotoTrabajador: Value(e.fotoTrabajador!),
                  nombreTrabajador: Value(e.nombreTrabajador!),
                  estado: Value(e.estado),
                  horaSalida: Value(e.horaSalida),
                  fechaSalida: Value(e.fechaSalida),
                  horaIngreso: Value(e.horaIngreso),
                  fechaIngreso: Value(e.fechaIngreso),
                  equipoId: Value(e.equipoId),
                  id: Value(e.id!),
                  horarioId: Value(e.horarioId),
                ),
              )
              .toList(),
        );
      });
    } catch (e) {
      print('Error al sincronizar registros: $e');
    }
  }

  Future<RegistroDiario> registrarEntrada(
    int equipoId,
    int horaAprobadaId,
  ) async {
    try {
      // Simular una llamada a la API
      final registrosDiarios = await getRegistroDiario();

      // Buscar información del trabajador
      final trabajador = registrosDiarios.firstWhere(
        (registro) => registro.equipoId == equipoId,
        orElse:
            () => RegistroDiario(
              equipoId: equipoId,
              fechaIngreso: DateTime.now(),
              horaIngreso: TimeOfDay.now(),
              nombreTrabajador: 'Trabajador #$equipoId',
              horarioId: horaAprobadaId,
            ),
      );

      // Crear nuevo registro
      final nuevoRegistro = RegistroDiario(
        id: registrosDiarios.length + 1,
        equipoId: equipoId,
        fechaIngreso: DateTime.now(),
        horaIngreso: TimeOfDay.now(),
        estado: true,
        nombreTrabajador: trabajador.nombreTrabajador,
        fotoTrabajador: trabajador.fotoTrabajador,
        cargoTrabajador: trabajador.cargoTrabajador,
        horarioId: horaAprobadaId,
      );

      // En una implementación real, aquí se guardaría en la base de datos
      await _db
          .into(_db.registrosDiarios)
          .insert(
            RegistrosDiariosCompanion(
              id: Value(nuevoRegistro.id!),
              equipoId: Value(nuevoRegistro.equipoId),
              fechaIngreso: Value(nuevoRegistro.fechaIngreso),
              horaIngreso: Value(nuevoRegistro.horaIngreso),
              estado: Value(nuevoRegistro.estado),
              nombreTrabajador: Value(
                nuevoRegistro.nombreTrabajador ?? "Desconocido",
              ),
              fotoTrabajador: Value(nuevoRegistro.fotoTrabajador ?? ""),
              cargoTrabajador: Value(
                nuevoRegistro.cargoTrabajador ?? "Desconocido",
              ),
              horarioId: Value(nuevoRegistro.horarioId),
            ),
          );

      return nuevoRegistro;
    } catch (e) {
      throw Exception('Error al registrar entrada: $e');
    }
  }

  Future<RegistroDiario> registrarSalida(
    int registroId,
    int horaAprobadaId,
  ) async {
    // Simular una llamada a la API
    final registrosDiarios = await getRegistroDiario();

    // Buscar el registro
    final index = registrosDiarios.indexWhere(
      (registro) => registro.id == registroId,
    );
    if (index == -1) {
      throw Exception('Registro no encontrado');
    }

    // Actualizar el registro con la salida
    final registroActualizado = registrosDiarios[index].copyWith(
      fechaSalida: DateTime.now(),
      horaSalida: TimeOfDay.now(),
      horarioId: horaAprobadaId,
    );

    await _db
        .update(_db.registrosDiarios)
        .replace(RegistroDiarioMapper.toDataModel(registroActualizado));

    return registroActualizado;
  }

  Future<RegistroDiario?> isEntry(int equipoId) async {
    final registrosDiarios = await getRegistroDiario();
    final hoy = DateTime.now();

    try {
      return registrosDiarios.firstWhere((registro) {
        return registro.equipoId == equipoId &&
            registro.fechaIngreso.year == hoy.year &&
            registro.fechaIngreso.month == hoy.month &&
            registro.fechaIngreso.day == hoy.day;
      });
    } catch (e) {
      return null; // No encontrado
    }
  }

  Future<RegistroDiario> registrarAsistencia(
    int equipoId,
    int horaAprobadaId,
  ) async {
    final hoy = DateTime.now();
    final registrosDiarios = await getRegistroDiario();
    final registrosHoy =
        registrosDiarios.where((registro) {
          return registro.equipoId == equipoId &&
              registro.fechaIngreso.year == hoy.year &&
              registro.fechaIngreso.month == hoy.month &&
              registro.fechaIngreso.day == hoy.day;
        }).toList();

    if (registrosHoy.isEmpty) {
      // No hay registro de entrada hoy, registrar entrada
      return await registrarEntrada(equipoId, horaAprobadaId);
    } else {
      // Ya hay un registro de entrada, registrar salida sobre el último registro de hoy
      final registroDelDia = registrosHoy.lastWhere(
        (registro) => registro.fechaSalida == null,
        orElse: () => registrosHoy.last,
      );

      return await registrarSalida(registroDelDia.id!, horaAprobadaId);
    }
  }

  Future<RegistroDiario?> buscarRegistroLocal(
    int equipoId,
    DateTime fechaIngreso,
  ) async {
    final registros = await _db.select(_db.registrosDiarios).get();

    for (final registro in registros) {
      if (registro.equipoId == equipoId &&
          registro.fechaIngreso.year == fechaIngreso.year &&
          registro.fechaIngreso.month == fechaIngreso.month &&
          registro.fechaIngreso.day == fechaIngreso.day) {
        return RegistroDiario.fromDataModel(registro);
      }
    }
    return null;
  }

  Future<void> insertarRegistroLocal(RegistroDiario registro) async {
    await _db
        .into(_db.registrosDiarios)
        .insert(
          RegistrosDiariosCompanion(
            equipoId: Value(registro.equipoId),
            reconocimientoFacialId: Value(registro.reconocimientoFacialId),
            fechaIngreso: Value(registro.fechaIngreso),
            horaIngreso: Value(registro.horaIngreso),
            fechaSalida:
                registro.fechaSalida != null
                    ? Value(registro.fechaSalida!)
                    : const Value.absent(),
            horaSalida:
                registro.horaSalida != null
                    ? Value(registro.horaSalida!)
                    : const Value.absent(),
            estado: Value(registro.estado),
            nombreTrabajador: Value(registro.nombreTrabajador ?? "Desconocido"),
            fotoTrabajador: Value(registro.fotoTrabajador ?? ""),
            cargoTrabajador: Value(registro.cargoTrabajador ?? "Desconocido"),
            horarioId: Value(registro.horarioId),
          ),
        );
  }

  Future<void> actualizarRegistroLocal(RegistroDiario registro) async {
    await (_db.update(_db.registrosDiarios)..where(
      (tbl) =>
          tbl.equipoId.equals(registro.equipoId) &
          tbl.fechaIngreso.equals(DateConverter().toSql(registro.fechaIngreso)),
    )).write(
      RegistrosDiariosCompanion(
        reconocimientoFacialId: Value(registro.reconocimientoFacialId),
        horaIngreso: Value(registro.horaIngreso),
        fechaSalida:
            registro.fechaSalida != null
                ? Value(registro.fechaSalida!)
                : const Value.absent(),
        horaSalida:
            registro.horaSalida != null
                ? Value(registro.horaSalida!)
                : const Value.absent(),
        estado: Value(registro.estado),
        nombreTrabajador: Value(registro.nombreTrabajador ?? "Desconocido"),
        fotoTrabajador: Value(registro.fotoTrabajador ?? ""),
        cargoTrabajador: Value(registro.cargoTrabajador ?? "Desconocido"),
        horarioId: Value(registro.horarioId),
      ),
    );
  }
}
