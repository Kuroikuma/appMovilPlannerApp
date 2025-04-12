import '../../../core/error/exceptions.dart';
import '../../../domain/models/registro_diario.dart';
import '../../../domain/repositories/i_registro_diario_repository.dart';
import '../../core/network/network_info.dart';
import 'local/registro_diario_repository_local.dart';
import 'remote/registro_diario_repository_remote.dart';

class RegistroDiarioRepository implements IRegistroDiarioRepository {
  final RegistroDiarioRepositoryLocal localDataSource;
  final RegistroDiarioRepositoryRemote remoteDataSource;
  final NetworkInfo networkInfo;

  RegistroDiarioRepository({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
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
  Future<RegistroDiario?> obtenerRegistroPorId(int id) async {
    final registrosDiarios = await localDataSource.getRegistroDiario();

    try {
      return registrosDiarios.firstWhere((registro) => registro.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<RegistroDiario> registrarEntrada(
    int equipoId, {
    int? reconocimientoFacialId,
  }) async {
    final registro = await remoteDataSource.registrarEntrada(
      equipoId,
      reconocimientoFacialId: reconocimientoFacialId,
    );

    return registro;
  }

  @override
  Future<RegistroDiario> registrarSalida(
    int registroId, {
    int? reconocimientoFacialId,
  }) async {
    final registroActualizado = await remoteDataSource.registrarSalida(
      registroId,
      reconocimientoFacialId: reconocimientoFacialId,
    );

    return registroActualizado;
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
  Future<void> cambiarEstadoRegistro(int registroId, bool estado) async {
    await remoteDataSource.cambiarEstadoRegistro(registroId, estado);
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
