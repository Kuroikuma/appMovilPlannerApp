import '../../../domain/i_ubicacion_repository.dart';
import '../../../data/database.dart';
import 'package:riverpod/riverpod.dart';

import '../repositories.dart';

// Estado que contiene la ubicación y si está verificada
class UbicacionState {
  final Ubicacione? ubicacion;
  final String ubicacionId;
  final bool? isVerify;
  final bool isLoading;
  final bool isShowConfig;

  const UbicacionState({
    this.ubicacion,
    this.ubicacionId = '',
    this.isVerify,
    this.isLoading = false,
    this.isShowConfig = false,
  });

  UbicacionState copyWith({
    Ubicacione? ubicacion,
    String? ubicacionId,
    bool? isVerify,
    bool? isLoading,
    bool? isShowConfig,
  }) {
    return UbicacionState(
      ubicacion: ubicacion ?? this.ubicacion,
      ubicacionId: ubicacionId ?? this.ubicacionId,
      isVerify: isVerify ?? this.isVerify,
      isLoading: isLoading ?? this.isLoading,
      isShowConfig: isShowConfig ?? this.isShowConfig,
    );
  }
}

final ubicacionNotifierProvider =
    StateNotifierProvider<UbicacionNotifier, UbicacionState>((ref) {
      return UbicacionNotifier(ref.watch(ubicacionRepositoryProvider));
    });

class UbicacionNotifier extends StateNotifier<UbicacionState> {
  final IUbicacionRepository _repository;

  UbicacionNotifier(this._repository) : super(const UbicacionState());

  Future<void> obtenerUbicacionConfigurada() async {
    state = state.copyWith(isLoading: true);
    try {
      final ubicacion = await _repository.obtenerUbicacionConfigurada();
      state = state.copyWith(ubicacion: ubicacion, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> configurarUbicacion(String codigoUbicacion) async {
    state = state.copyWith(isLoading: true);
    final ubicacionId = state.ubicacionId;
    try {
      final ubicacionData = await _repository.configurarUbicacion(
        codigoUbicacion,
        ubicacionId.toString(),
      );
      state = state.copyWith(ubicacion: ubicacionData, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> verificarUbicacionConfigurada() async {
    state = state.copyWith(isLoading: true);

    try {
      final isVerifyLocal = await _repository.verificarUbicacionConfigurada();
      state = state.copyWith(isVerify: isVerifyLocal, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> verificarUbicacion(String codigoUbicacion) async {
    state = state.copyWith(isLoading: true);
    try {
      await obtenerUbicacionId(codigoUbicacion);
      await verificarUbicacionConfigurada();
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> showConfigurarUbicacion() async {
    state = state.copyWith(isShowConfig: true);
  }

  Future<void> hideConfigurarUbicacion() async {
    state = state.copyWith(isShowConfig: false);
  }

  Future<void> toggleConfigurarUbicacion() async {
    state = state.copyWith(isShowConfig: !state.isShowConfig);
  }

  Future<void> obtenerUbicacionId(String codigoUbicacion) async {
    final ubicacionId = await _repository.obtenerUbicacionId(codigoUbicacion);
    state = state.copyWith(ubicacionId: ubicacionId);
  }

  Future<void> eliminarUbicacion() async {
    await _repository.eliminarUbicacion();
    state = state.copyWith(ubicacion: null, ubicacionId: '', isVerify: null);
  }
}
