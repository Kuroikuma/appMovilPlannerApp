import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/models/registro_diario.dart';
import '../../../domain/repositories/i_registro_diario_repository.dart';
import '../providers.dart';
import '../repositories.dart';

enum RegistroFilterType { todos, soloEntrada, conSalida, inactivos }

class RegistroDiarioState {
  final List<RegistroDiario> registros;
  final List<RegistroDiario> registrosFiltrados;
  final bool isLoading;
  final String? errorMessage;
  final DateTime? fechaSeleccionada;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final int? trabajadorSeleccionadoId;
  final RegistroFilterType filterType;

  const RegistroDiarioState({
    this.registros = const [],
    this.registrosFiltrados = const [],
    this.isLoading = false,
    this.errorMessage,
    this.fechaSeleccionada,
    this.fechaInicio,
    this.fechaFin,
    this.trabajadorSeleccionadoId,
    this.filterType = RegistroFilterType.todos,
  });

  RegistroDiarioState copyWith({
    List<RegistroDiario>? registros,
    List<RegistroDiario>? registrosFiltrados,
    bool? isLoading,
    String? errorMessage,
    DateTime? fechaSeleccionada,
    DateTime? fechaInicio,
    DateTime? fechaFin,
    int? trabajadorSeleccionadoId,
    RegistroFilterType? filterType,
  }) {
    return RegistroDiarioState(
      registros: registros ?? this.registros,
      registrosFiltrados: registrosFiltrados ?? this.registrosFiltrados,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      fechaSeleccionada: fechaSeleccionada ?? this.fechaSeleccionada,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      trabajadorSeleccionadoId:
          trabajadorSeleccionadoId ?? this.trabajadorSeleccionadoId,
      filterType: filterType ?? this.filterType,
    );
  }

  // Método para limpiar errores
  RegistroDiarioState clearErrors() {
    return RegistroDiarioState(
      registros: registros,
      registrosFiltrados: registrosFiltrados,
      isLoading: isLoading,
      fechaSeleccionada: fechaSeleccionada,
      fechaInicio: fechaInicio,
      fechaFin: fechaFin,
      trabajadorSeleccionadoId: trabajadorSeleccionadoId,
      filterType: filterType,
    );
  }
}

final registroDiarioNotifierProvider =
    StateNotifierProvider<RegistroDiarioNotifier, RegistroDiarioState>((ref) {
      return RegistroDiarioNotifier(
        ref.watch(registroDiarioRepositoryProvider),
        ref.watch(networkInfoProvider),
      );
    });

class RegistroDiarioNotifier extends StateNotifier<RegistroDiarioState> {
  final IRegistroDiarioRepository _repository;
  final NetworkInfo networkInfo;

  RegistroDiarioNotifier(this._repository, this.networkInfo)
    : super(const RegistroDiarioState());

  Future<void> cargarRegistros(String ubicacionId, {DateTime? fecha}) async {
    state = state.copyWith(isLoading: true).clearErrors();

    // Verificar conexión a internet
    final hasInternet = await networkInfo.isConnected;
    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay conexión a internet',
      );
      return;
    }

    try {
      final registros = await _repository.obtenerRegistrosPorUbicacion(
        ubicacionId,
        fecha: fecha,
      );

      state = state.copyWith(
        registros: registros,
        registrosFiltrados: registros,
        isLoading: false,
        fechaSeleccionada: fecha,
      );

      // Aplicar filtros actuales
      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> cargarRegistrosPorRango(
    String ubicacionId, {
    DateTime? fechaInicio,
    DateTime? fechaFin,
  }) async {
    state =
        state
            .copyWith(
              isLoading: true,
              fechaInicio: fechaInicio,
              fechaFin: fechaFin,
            )
            .clearErrors();

    // Verificar conexión a internet
    final hasInternet = await networkInfo.isConnected;
    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay conexión a internet',
      );
      return;
    }

    try {
      // Si no se proporciona un rango, usar la fecha seleccionada
      if (fechaInicio == null &&
          fechaFin == null &&
          state.fechaSeleccionada != null) {
        await cargarRegistros(ubicacionId, fecha: state.fechaSeleccionada);
        return;
      }

      // Obtener todos los registros y filtrar por rango de fechas
      final registros = await _repository.obtenerRegistrosPorUbicacion(
        ubicacionId,
      );

      List<RegistroDiario> registrosFiltrados = registros;

      if (fechaInicio != null || fechaFin != null) {
        registrosFiltrados =
            registros.where((registro) {
              final fecha = registro.fechaIngreso;

              if (fechaInicio != null && fechaFin != null) {
                // Normalizar fechas para comparación (sin hora)
                final inicio = DateTime(
                  fechaInicio.year,
                  fechaInicio.month,
                  fechaInicio.day,
                );
                final fin = DateTime(
                  fechaFin.year,
                  fechaFin.month,
                  fechaFin.day,
                );
                final registroFecha = DateTime(
                  fecha.year,
                  fecha.month,
                  fecha.day,
                );

                return registroFecha.isAtSameMomentAs(inicio) ||
                    registroFecha.isAtSameMomentAs(fin) ||
                    (registroFecha.isAfter(inicio) &&
                        registroFecha.isBefore(fin));
              } else if (fechaInicio != null) {
                final inicio = DateTime(
                  fechaInicio.year,
                  fechaInicio.month,
                  fechaInicio.day,
                );
                final registroFecha = DateTime(
                  fecha.year,
                  fecha.month,
                  fecha.day,
                );
                return registroFecha.isAtSameMomentAs(inicio) ||
                    registroFecha.isAfter(inicio);
              } else if (fechaFin != null) {
                final fin = DateTime(
                  fechaFin.year,
                  fechaFin.month,
                  fechaFin.day,
                );
                final registroFecha = DateTime(
                  fecha.year,
                  fecha.month,
                  fecha.day,
                );
                return registroFecha.isAtSameMomentAs(fin) ||
                    registroFecha.isBefore(fin);
              }

              return true;
            }).toList();
      }

      state = state.copyWith(
        registros: registrosFiltrados,
        registrosFiltrados: registrosFiltrados,
        isLoading: false,
      );

      // Aplicar filtros actuales
      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> registrarEntrada(
    int equipoId, {
    String? registroBiometricoId,
  }) async {
    state = state.copyWith(isLoading: true).clearErrors();

    // Verificar conexión a internet
    final hasInternet = await networkInfo.isConnected;
    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay conexión a internet',
      );
      return;
    }

    try {
      final nuevoRegistro = await _repository.registrarEntrada(
        equipoId,
        registroBiometricoId: registroBiometricoId,
      );

      // Actualizar la lista de registros
      final registrosActualizados = [...state.registros, nuevoRegistro];

      state = state.copyWith(
        registros: registrosActualizados,
        isLoading: false,
      );

      // Aplicar filtros actuales
      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> registrarSalida(
    int registroId, {
    String? registroBiometricoId,
  }) async {
    state = state.copyWith(isLoading: true).clearErrors();

    // Verificar conexión a internet
    final hasInternet = await networkInfo.isConnected;
    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay conexión a internet',
      );
      return;
    }

    try {
      final registroActualizado = await _repository.registrarSalida(
        registroId,
        registroBiometricoId: registroBiometricoId,
      );

      // Actualizar el registro en la lista
      final registrosActualizados =
          state.registros.map((registro) {
            if (registro.id == registroId) {
              return registroActualizado;
            }
            return registro;
          }).toList();

      state = state.copyWith(
        registros: registrosActualizados,
        isLoading: false,
      );

      // Aplicar filtros actuales
      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> cambiarEstadoRegistro(int registroId, bool estado) async {
    state = state.copyWith(isLoading: true).clearErrors();

    // Verificar conexión a internet
    final hasInternet = await networkInfo.isConnected;
    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay conexión a internet',
      );
      return;
    }

    try {
      await _repository.cambiarEstadoRegistro(registroId, estado);

      // Actualizar el estado del registro en la lista local
      final registrosActualizados =
          state.registros.map((registro) {
            if (registro.id == registroId) {
              return registro.copyWith(estado: estado);
            }
            return registro;
          }).toList();

      state = state.copyWith(
        registros: registrosActualizados,
        isLoading: false,
      );

      // Aplicar filtros actuales
      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void filtrarPorTipo(RegistroFilterType filterType) {
    state = state.copyWith(filterType: filterType);
    _aplicarFiltros();
  }

  void filtrarPorTrabajador(int? trabajadorId) {
    state = state.copyWith(trabajadorSeleccionadoId: trabajadorId);
    _aplicarFiltros();
  }

  void filtrarPorFecha(DateTime? fecha) {
    state = state.copyWith(
      fechaSeleccionada: fecha,
      fechaInicio: null,
      fechaFin: null,
    );
    // Aquí no aplicamos filtros porque necesitamos cargar los registros de la nueva fecha
  }

  void filtrarPorRangoFechas(DateTime? fechaInicio, DateTime? fechaFin) {
    state = state.copyWith(
      fechaInicio: fechaInicio,
      fechaFin: fechaFin,
      fechaSeleccionada: null,
    );
    // Aquí no aplicamos filtros porque necesitamos cargar los registros del nuevo rango
  }

  void _aplicarFiltros() {
    List<RegistroDiario> filtrados = List.from(state.registros);

    // Filtrar por tipo
    switch (state.filterType) {
      case RegistroFilterType.soloEntrada:
        filtrados = filtrados.where((r) => !r.tieneSalida).toList();
        break;
      case RegistroFilterType.conSalida:
        filtrados = filtrados.where((r) => r.tieneSalida).toList();
        break;
      case RegistroFilterType.inactivos:
        filtrados = filtrados.where((r) => !r.estado).toList();
        break;
      case RegistroFilterType.todos:
      default:
        // No aplicar filtro adicional
        break;
    }

    // Filtrar por trabajador
    if (state.trabajadorSeleccionadoId != null) {
      filtrados =
          filtrados
              .where((r) => r.equipoId == state.trabajadorSeleccionadoId)
              .toList();
    }

    state = state.copyWith(registrosFiltrados: filtrados);
  }

  // Método para limpiar errores
  void clearErrors() {
    state = state.clearErrors();
  }
}
