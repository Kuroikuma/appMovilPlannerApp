import 'package:drift/drift.dart';
import 'package:flutter_application_1/data/database.dart';
import '../../../domain/models/registro_diario.dart';

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
                  horaSalida: Value(e.horaSalida!),
                  fechaSalida: Value(e.fechaSalida!),
                  horaIngreso: Value(e.horaIngreso),
                  fechaIngreso: Value(e.fechaIngreso),
                  equipoId: Value(e.equipoId),
                  id: Value(e.id!),
                ),
              )
              .toList(),
        );
      });
    } catch (e) {
      print('Error al sincronizar registros: $e');
    }
  }
}
