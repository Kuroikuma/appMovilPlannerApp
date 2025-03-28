import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/entities.dart';
import '../../../domain/models/reconocimiento_facial.dart';
import '../../../domain/repositories/i_reconocimiento_facial_repository.dart';
import '../providers.dart';
import '../repositories.dart';

enum ReconocimientoFacialEstado {
  inicial,
  capturando,
  procesando,
  exito,
  error,
}

class ReconocimientoFacialStateData {
  final ReconocimientoFacialEstado estado;
  final bool isLoading;
  final String? errorMessage;
  final String? imagenBase64;
  final Trabajador? trabajadorIdentificado;
  final List<ReconocimientoFacial> reconocimientos;
  final bool registroExitoso;

  const ReconocimientoFacialStateData({
    this.estado = ReconocimientoFacialEstado.inicial,
    this.isLoading = false,
    this.errorMessage,
    this.imagenBase64,
    this.trabajadorIdentificado,
    this.reconocimientos = const [],
    this.registroExitoso = false,
  });

  ReconocimientoFacialStateData copyWith({
    ReconocimientoFacialEstado? estado,
    bool? isLoading,
    String? errorMessage,
    String? imagenBase64,
    Trabajador? trabajadorIdentificado,
    List<ReconocimientoFacial>? reconocimientos,
    bool? registroExitoso,
  }) {
    return ReconocimientoFacialStateData(
      estado: estado ?? this.estado,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      imagenBase64: imagenBase64 ?? this.imagenBase64,
      trabajadorIdentificado:
          trabajadorIdentificado ?? this.trabajadorIdentificado,
      reconocimientos: reconocimientos ?? this.reconocimientos,
      registroExitoso: registroExitoso ?? this.registroExitoso,
    );
  }

  // Método para limpiar errores
  ReconocimientoFacialStateData clearErrors() {
    return ReconocimientoFacialStateData(
      estado: estado,
      isLoading: isLoading,
      imagenBase64: imagenBase64,
      trabajadorIdentificado: trabajadorIdentificado,
      reconocimientos: reconocimientos,
      registroExitoso: registroExitoso,
    );
  }
}

final reconocimientoFacialNotifierProvider = StateNotifierProvider<
  ReconocimientoFacialNotifier,
  ReconocimientoFacialStateData
>((ref) {
  return ReconocimientoFacialNotifier(
    ref.watch(reconocimientoFacialRepositoryProvider),
    ref.watch(networkInfoProvider),
  );
});

class ReconocimientoFacialNotifier
    extends StateNotifier<ReconocimientoFacialStateData> {
  final IReconocimientoFacialRepository _repository;
  final NetworkInfo networkInfo;

  ReconocimientoFacialNotifier(this._repository, this.networkInfo)
    : super(const ReconocimientoFacialStateData());

  Future<void> obtenerReconocimientosPorTrabajador(String trabajadorId) async {
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
      final reconocimientos = await _repository
          .obtenerReconocimientosPorTrabajador(trabajadorId);

      state = state.copyWith(
        reconocimientos: reconocimientos,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> registrarReconocimientoFacial(
    String trabajadorId,
    String imagenBase64,
  ) async {
    state =
        state
            .copyWith(
              isLoading: true,
              estado: ReconocimientoFacialEstado.procesando,
              imagenBase64: imagenBase64,
            )
            .clearErrors();

    // Verificar conexión a internet
    final hasInternet = await networkInfo.isConnected;
    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay conexión a internet',
        estado: ReconocimientoFacialEstado.error,
      );
      return;
    }

    try {
      final nuevoReconocimiento = await _repository
          .registrarReconocimientoFacial(trabajadorId, imagenBase64);

      // Actualizar la lista de reconocimientos
      final reconocimientosActualizados = [
        ...state.reconocimientos,
        nuevoReconocimiento,
      ];

      state = state.copyWith(
        reconocimientos: reconocimientosActualizados,
        isLoading: false,
        estado: ReconocimientoFacialEstado.exito,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        estado: ReconocimientoFacialEstado.error,
      );
    }
  }

  Future<void> identificarTrabajador(String imagenBase64) async {
    state =
        state
            .copyWith(
              isLoading: true,
              estado: ReconocimientoFacialEstado.procesando,
              imagenBase64: imagenBase64,
              trabajadorIdentificado: null,
              registroExitoso: false,
            )
            .clearErrors();

    // Verificar conexión a internet
    final hasInternet = await networkInfo.isConnected;
    if (!hasInternet) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay conexión a internet',
        estado: ReconocimientoFacialEstado.error,
      );
      return;
    }

    try {
      final trabajador = await _repository.identificarTrabajador(imagenBase64);

      if (trabajador != null) {
        state = state.copyWith(
          trabajadorIdentificado: trabajador,
          isLoading: false,
          estado: ReconocimientoFacialEstado.exito,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'No se pudo identificar al trabajador',
          estado: ReconocimientoFacialEstado.error,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        estado: ReconocimientoFacialEstado.error,
      );
    }
  }

  Future<void> registrarAsistenciaPorReconocimiento() async {
    if (state.trabajadorIdentificado == null) {
      state = state.copyWith(
        errorMessage: 'No hay trabajador identificado',
        estado: ReconocimientoFacialEstado.error,
      );
      return;
    }

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
      final exito = await _repository.registrarAsistenciaPorReconocimiento(
        state.trabajadorIdentificado!.id.toString(),
      );

      state = state.copyWith(
        isLoading: false,
        registroExitoso: exito,
        errorMessage: exito ? null : 'No se pudo registrar la asistencia',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        registroExitoso: false,
      );
    }
  }

  Future<void> eliminarReconocimientoFacial(String reconocimientoId) async {
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
      final exito = await _repository.eliminarReconocimientoFacial(
        reconocimientoId,
      );

      if (exito) {
        // Actualizar la lista de reconocimientos
        final reconocimientosActualizados =
            state.reconocimientos
                .where((r) => r.id != reconocimientoId)
                .toList();

        state = state.copyWith(
          reconocimientos: reconocimientosActualizados,
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'No se pudo eliminar el reconocimiento facial',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void reiniciarEstado() {
    state = const ReconocimientoFacialStateData();
  }

  void cambiarEstado(ReconocimientoFacialEstado nuevoEstado) {
    state = state.copyWith(estado: nuevoEstado);
  }

  // Método para limpiar errores
  void clearErrors() {
    state = state.clearErrors();
  }
}
