import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/entities.dart';
import '../../../domain/repositories.dart';
import '../providers.dart';
import '../repositories.dart';

enum TrabajadorFilterType { todos, activos, inactivos }

class TrabajadorState {
  final List<Trabajador> trabajadores;
  final List<Trabajador> trabajadoresFiltrados;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;
  final TrabajadorFilterType filterType;

  const TrabajadorState({
    this.trabajadores = const [],
    this.trabajadoresFiltrados = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
    this.filterType = TrabajadorFilterType.todos,
  });

  TrabajadorState copyWith({
    List<Trabajador>? trabajadores,
    List<Trabajador>? trabajadoresFiltrados,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
    TrabajadorFilterType? filterType,
  }) {
    return TrabajadorState(
      trabajadores: trabajadores ?? this.trabajadores,
      trabajadoresFiltrados:
          trabajadoresFiltrados ?? this.trabajadoresFiltrados,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      filterType: filterType ?? this.filterType,
    );
  }
}

final trabajadorNotifierProvider =
    StateNotifierProvider<TrabajadorNotifier, TrabajadorState>((ref) {
      return TrabajadorNotifier(
        ref.watch(trabajadorRepositoryProvider),
        ref.watch(networkInfoProvider),
      );
    });

class TrabajadorNotifier extends StateNotifier<TrabajadorState> {
  final ITrabajadorRepository _repository;
  final NetworkInfo networkInfo;

  TrabajadorNotifier(this._repository, this.networkInfo)
    : super(const TrabajadorState());

  Future<void> cargarTrabajadores(String ubicacionId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Verificar conexión a internet
    final hasInternet = await networkInfo.isConnected;
    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay conexión a internet',
      );
      return;
    }

    print('ubicacionId: $ubicacionId');

    try {
      final trabajadores = await _repository.obtenerTrabajadoresPorUbicacion(
        ubicacionId,
      );

      state = state.copyWith(
        trabajadores: trabajadores,
        trabajadoresFiltrados: trabajadores,
        isLoading: false,
      );

      // Aplicar filtros actuales
      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void buscarTrabajadores(String query) {
    state = state.copyWith(searchQuery: query);
    _aplicarFiltros();
  }

  void filtrarPorEstado(TrabajadorFilterType filterType) {
    state = state.copyWith(filterType: filterType);
    _aplicarFiltros();
  }

  void _aplicarFiltros() {
    List<Trabajador> filtrados = List.from(state.trabajadores);

    // Filtrar por estado (activo/inactivo)
    if (state.filterType == TrabajadorFilterType.activos) {
      filtrados = filtrados.where((t) => t.faceSync == true).toList();
    } else if (state.filterType == TrabajadorFilterType.inactivos) {
      filtrados = filtrados.where((t) => t.faceSync == false).toList();
    }

    // Filtrar por búsqueda
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtrados =
          filtrados
              .where(
                (t) =>
                    t.nombre.toLowerCase().contains(query) ||
                    t.primerApellido.toLowerCase().contains(query) ||
                    t.segundoApellido.toLowerCase().contains(query),
              )
              .toList();
    }

    state = state.copyWith(trabajadoresFiltrados: filtrados);
  }
}
