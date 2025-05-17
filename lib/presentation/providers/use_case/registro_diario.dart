import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/models/registro_diario.dart';
import '../../../domain/repositories/i_registro_diario_repository.dart';
import '../providers.dart';
import '../repositories.dart';
import 'horario_notifier.dart';

enum RegistroFilterType { todos, soloEntrada, conSalida, inactivos }

enum RegistroType { entrada, salida }

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
  final RegistroType tipoRegistro;

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
    this.tipoRegistro = RegistroType.entrada,
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
    RegistroType? tipoRegistro,
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
      tipoRegistro: tipoRegistro ?? this.tipoRegistro,
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
        ref,
      );
    });

class RegistroDiarioNotifier extends StateNotifier<RegistroDiarioState> {
  final IRegistroDiarioRepository _repository;
  final NetworkInfo networkInfo;
  final Ref ref;

  RegistroDiarioNotifier(this._repository, this.networkInfo, this.ref)
    : super(const RegistroDiarioState());

  Future<void> cargarRegistros(String ubicacionId, {DateTime? fecha}) async {
    state = state.copyWith(isLoading: true).clearErrors();

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

  Future<RegistroDiario?> obtenerRegistroPorEquipo(int equipoId) async {
    final registroDiarioEntrada = await _repository.obtenerRegistroPorEquipo(
      equipoId,
    );

    return registroDiarioEntrada;
  }

  Future<void> tipoRegistroAsistencia(int equipoId) async {
    final registroDiarioEntrada = await _repository.obtenerRegistroPorEquipo(
      equipoId,
    );

    if (registroDiarioEntrada != null) {
      state = state.copyWith(tipoRegistro: RegistroType.salida);
    } else {
      state = state.copyWith(tipoRegistro: RegistroType.entrada);
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

    try {
      // Si no se proporciona un rango, usar la fecha seleccionada
      if (fechaInicio == null &&
          fechaFin == null &&
          state.fechaSeleccionada != null) {
        await cargarRegistros(ubicacionId, fecha: state.fechaSeleccionada);
        return;
      }

      // Obtener todos los registros y filtrar por rango de fechas
      final registros = await _repository.obtenerRegistrosPorRangoFechas(
        ubicacionId,
        fechaInicio: fechaInicio,
        fechaFin: fechaFin,
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

  Future<void> registrarAsistencia(int equipoId) async {
    state = state.copyWith(isLoading: true).clearErrors();

    final horario = ref.read(horarioNotifierProvider).horario;

    if (horario == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay horario disponible',
      );
      return;
    }

    final horaAprobadaId = horario.id;

    try {
      final nuevoRegistro = await _repository.registrarAsistencia(
        equipoId,
        horaAprobadaId,
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
