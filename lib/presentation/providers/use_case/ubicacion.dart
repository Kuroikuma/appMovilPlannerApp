import 'package:flutter_application_1/core/network/network_info.dart';

import '../../../domain/repositories/i_ubicacion_repository.dart';
import '../../../data/database.dart';
import 'package:riverpod/riverpod.dart';

import '../providers.dart';
import '../repositories.dart';

// Enumeración para los tipos de errores
enum UbicacionErrorType { noInternet, serverError, notFound, unknown }

// Estado que contiene la ubicación y si está verificada
class UbicacionState {
  final Ubicacione? ubicacion;
  final String ubicacionId;
  final String ubicacionNombre;
  final bool? isVerify;
  final bool isLoading;
  final bool isShowConfig;
  final UbicacionErrorType? errorType;
  final String? errorMessage;

  const UbicacionState({
    this.ubicacion,
    this.ubicacionId = '',
    this.ubicacionNombre = '',
    this.isVerify = false,
    this.isLoading = false,
    this.isShowConfig = false,
    this.errorType,
    this.errorMessage,
  });

  UbicacionState copyWith({
    Ubicacione? ubicacion,
    String? ubicacionId,
    String? ubicacionNombre,
    bool? isVerify,
    bool? isLoading,
    bool? isShowConfig,
    UbicacionErrorType? errorType,
    String? errorMessage,
  }) {
    return UbicacionState(
      ubicacion: ubicacion ?? this.ubicacion,
      ubicacionId: ubicacionId ?? this.ubicacionId,
      ubicacionNombre: ubicacionNombre ?? this.ubicacionNombre,
      isVerify: isVerify ?? this.isVerify,
      isLoading: isLoading ?? this.isLoading,
      isShowConfig: isShowConfig ?? this.isShowConfig,
      errorType: errorType ?? this.errorType,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  UbicacionState clearErrors() {
    return UbicacionState(
      ubicacion: ubicacion,
      ubicacionId: ubicacionId,
      ubicacionNombre: ubicacionNombre,
      isVerify: isVerify,
      isLoading: isLoading,
      isShowConfig: isShowConfig,
    );
  }
}

final ubicacionNotifierProvider =
    StateNotifierProvider<UbicacionNotifier, UbicacionState>((ref) {
      return UbicacionNotifier(
        ref.watch(ubicacionRepositoryProvider),
        ref.watch(networkInfoProvider),
      );
    });

class UbicacionNotifier extends StateNotifier<UbicacionState> {
  final IUbicacionRepository _repository;
  final NetworkInfo networkInfo;

  UbicacionNotifier(this._repository, this.networkInfo)
    : super(const UbicacionState());

  Future<void> obtenerUbicacionConfigurada() async {
    state = state.copyWith(isLoading: true).clearErrors();
    try {
      final ubicacion = await _repository.obtenerUbicacionConfigurada();
      state = state.copyWith(ubicacion: ubicacion, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorType: UbicacionErrorType.serverError,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> configurarUbicacion(String codigoUbicacion) async {
    state = state.copyWith(isLoading: true).clearErrors();

    final hasInternet = await networkInfo.isConnected;

    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorType: UbicacionErrorType.noInternet,
        errorMessage: 'No hay conexión a internet',
      );
      return;
    }

    final ubicacionId = state.ubicacionId;
    final ubicacionNombre = state.ubicacionNombre;

    try {
      final ubicacionData = await _repository.configurarUbicacion(
        codigoUbicacion,
        ubicacionNombre,
        ubicacionId.toString(),
      );
      state = state.copyWith(
        ubicacion: ubicacionData,
        isLoading: false,
        isVerify: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorType: UbicacionErrorType.serverError,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> verificarUbicacionConfiguradaLocal() async {
    state = state.copyWith(isLoading: true).clearErrors();

    try {
      final isVerifyLocal =
          await _repository.verificarUbicacionConfiguradaLocal();

      if (isVerifyLocal) {
        final ubicacion = await _repository.obtenerUbicacionConfigurada();

        state = state.copyWith(
          ubicacion: ubicacion,
          isVerify: true,
          isLoading: false,
          ubicacionId: ubicacion.ubicacionId.toString(),
          ubicacionNombre: ubicacion.nombre,
        );
      } else {
        state = state.copyWith(isVerify: false, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorType: UbicacionErrorType.serverError,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> verificarUbicacion(String codigoUbicacion) async {
    state = state.copyWith(isLoading: true).clearErrors();

    final hasInternet = await networkInfo.isConnected;

    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorType: UbicacionErrorType.noInternet,
        errorMessage: 'No hay conexión a internet',
      );
      return;
    }

    try {
      await getUbicacionByCodigoUbicacion(codigoUbicacion);
      await verificarUbicacionConfiguradaLocal();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorType: UbicacionErrorType.serverError,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> showConfigurarUbicacion() async {
    state = state.copyWith(isShowConfig: true).clearErrors();
  }

  Future<void> hideConfigurarUbicacion() async {
    state = state.copyWith(isShowConfig: false).clearErrors();
  }

  Future<void> toggleConfigurarUbicacion() async {
    state = state.copyWith(isShowConfig: !state.isShowConfig).clearErrors();
  }

  Future<void> getUbicacionByCodigoUbicacion(String codigoUbicacion) async {
    try {
      state = state.copyWith(isLoading: true).clearErrors();
      final ubicacion = await _repository.getUbicacionByCodigoUbicacion(
        codigoUbicacion,
      );
      state = state.copyWith(
        ubicacionId: ubicacion['ubicacionId'],
        ubicacionNombre: ubicacion['ubicacionNombre'],
        isLoading: false,
      );
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
        errorType: UbicacionErrorType.serverError,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> eliminarUbicacion() async {
    state = state.copyWith(isLoading: true).clearErrors();

    final hasInternet = await networkInfo.isConnected;

    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorType: UbicacionErrorType.noInternet,
        errorMessage: 'No hay conexión a internet',
      );
      return;
    }

    await _repository.eliminarUbicacion(int.parse(state.ubicacionId));
    state = state.copyWith(
      ubicacion: null,
      ubicacionId: '',
      isVerify: false,
      isLoading: false,
      ubicacionNombre: '',
    );
  }

  void clearErrors() {
    state = state.clearErrors();
  }

  Future<void> handleSubmitConfiguracionUbicacion(
    String codigoUbicacion,
  ) async {
    print('handleSubmitConfiguracionUbicacion');
    await getUbicacionByCodigoUbicacion(codigoUbicacion);
    print('siuiente');
    await configurarUbicacion(codigoUbicacion);
    await verificarUbicacionConfiguradaLocal();
  }
}
