import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/exceptions.dart';
import '../../../domain/models/registro_diario.dart';
import '../../../domain/repositories/i_registro_diario_repository.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories.dart';
import '../converters/action_sync.dart';
import '../database.dart';
import 'local/registro_diario_repository_local.dart';
import 'remote/registro_diario_repository_remote.dart';

class RegistroDiarioRepository implements IRegistroDiarioRepository {
  final RegistroDiarioRepositoryLocal localDataSource;
  final RegistroDiarioRepositoryRemote remoteDataSource;
  final NetworkInfo networkInfo;
  final ISyncEntityRepository syncEntityRepository;

  RegistroDiarioRepository({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
    required this.syncEntityRepository,
  });

  // Datos de ejemplo para demostración
  Future<List<RegistroDiario>> getRegistroDiarioPorUbicacion(
    String ubicacionId,
    DateTime? fechaInicio,
    DateTime? fechaFin,
  ) async {
    final localData = await localDataSource.getRegistroDiario();
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteData = await remoteDataSource.getRegistroDiarioPorUbicacion(
          ubicacionId,
          fechaInicio,
          fechaFin,
        );
        print('remoteData: $remoteData');

        await localDataSource.syncronizarRegistrosDiarios(remoteData);
        return remoteData;
      } catch (e) {
        return localData.isNotEmpty ? localData : throw CacheException();
      }
    } else {
      return localData.isNotEmpty ? localData : throw NoInternetException();
    }
  }

  @override
  Future<List<RegistroDiario>> obtenerRegistrosPorUbicacion(
    String ubicacionId, {
    DateTime? fecha,
  }) async {
    final registrosDiarios = await getRegistroDiarioPorUbicacion(
      ubicacionId,
      fecha,
      fecha,
    );

    if (fecha == null) {
      return registrosDiarios;
    }

    return registrosDiarios.where((registro) {
      return registro.fechaIngreso.year == fecha.year &&
          registro.fechaIngreso.month == fecha.month &&
          registro.fechaIngreso.day == fecha.day;
    }).toList();
  }

  @override
  Future<RegistroDiario?> obtenerRegistroPorEquipo(int equipoId) async {
    final registroDiarioEntrada = await localDataSource.isEntry(equipoId);

    return registroDiarioEntrada;
  }

  @override
  Future<RegistroDiario?> obtenerRegistroPorId(int id) async {
    final registrosDiarios = await localDataSource.getRegistroDiario();

    try {
      return registrosDiarios.firstWhere((registro) => registro.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<RegistroDiario> registrarAsistencia(
    int equipoId,
    int horaAprobadaId, {
    int? trabajadorId,
  }) async {
    final registroDiarioEntrada = await localDataSource.isEntry(equipoId);

    if (registroDiarioEntrada != null) {
      if (!registroDiarioEntrada.puedeRegistrarSalida) {
        final tiempoRestante = registroDiarioEntrada.tiempoRestanteFormateado;
        throw CustomException(
          'Debe esperar $tiempoRestante antes de registrar la salida',
        );
      }
    }

    if (!await localDataSource.sePuedeRegistrarAsistencia()) {
      throw CustomException('No puedes registrar entrada en este momento');
    }

    final isEntry = registroDiarioEntrada != null;

    if (!isEntry) {
      final isInside = await localDataSource.estaDentroDelHorario();

      if (!isInside) {
        throw CustomException('No puedes registrar entrada en este momento');
      }
    }

    final registroAsistencia = await localDataSource.registrarAsistencia(
      equipoId,
      horaAprobadaId,
      trabajadorId,
    );

    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteData = await remoteDataSource.registrarAsistencia(
          equipoId,
          horaAprobadaId,
          isEntry,
          isEntry ? registroAsistencia.fechaIngreso : null,
          isEntry ? registroAsistencia.horaIngreso : null,
          isEntry ? registroAsistencia.id : null,
        );

        await localDataSource.actualizarRegistroLocal(remoteData);
        return remoteData;
      } catch (e) {
        throw ApiException();
      }
    } else {
      if (isEntry) {
        await insertQueuSyncRegistroDiario(
          registroAsistencia,
          TipoAccionesSync.update,
        );
      } else {
        await insertQueuSyncRegistroDiario(
          registroAsistencia,
          TipoAccionesSync.post,
        );
      }

      return registroAsistencia;
    }
  }

  Future<void> insertQueuSyncRegistroDiario(
    RegistroDiario registroAsistencia,
    TipoAccionesSync accion,
  ) async {
    final uuid = const Uuid();
    final id = uuid.v4();
    syncEntityRepository.insertSyncEntity(
      SyncsEntitysCompanion(
        entityTableNameToSync: Value('registroDiario'),
        action: Value(accion),
        registerId: Value("${registroAsistencia.id}"),
        timestamp: Value(DateTime.now()),
        isSynced: Value(false),
        data: Value(registroAsistencia.toJson()),
        id: Value(id),
      ),
    );
  }

  Future<void> updateQueuSyncRegistroDiario(
    SyncsEntitysCompanion registroAsistencia,
  ) async {
    syncEntityRepository.updateSyncEntity(registroAsistencia);
  }

  @override
  Future<List<RegistroDiario>> obtenerRegistrosPorTrabajador(
    int equipoId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    final registrosDiarios = await localDataSource.getRegistroDiario();

    if (fechaInicio == null && fechaFin == null) {
      return registrosDiarios;
    }

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

  @override
  Future<List<RegistroDiario>> obtenerRegistrosPorRangoFechas(
    String ubicacionId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    // Simular una llamada a la API
    final registrosDiarios = await getRegistroDiarioPorUbicacion(
      ubicacionId,
      fechaInicio,
      fechaFin,
    );

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
}
