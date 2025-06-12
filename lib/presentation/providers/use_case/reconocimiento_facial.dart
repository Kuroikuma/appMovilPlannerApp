import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter_application_1/domain/repositories/i_registro_biometrico_repository.dart';
import 'package:flutter_application_1/presentation/providers/use_case/registro_diario.dart';
import 'package:flutter_application_1/presentation/providers/use_case/trabajador.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/entities.dart';
import '../../../domain/models/reconocimiento_facial.dart';
import '../../../domain/models/registro_biometrico.dart';
import '../../../domain/repositories/i_reconocimiento_facial_repository.dart';
import '../providers.dart';
import '../repositories.dart';
import 'horario_notifier.dart';
import 'ubicacion.dart';

enum ReconocimientoFacialEstado {
  inicial,
  capturando,
  procesando,
  exito,
  error,
  inactivo,
  pausado,
}

class ReconocimientoFacialStateData {
  final ReconocimientoFacialEstado estado;
  final bool isLoading;
  final String? errorMessage;
  final String? imagenBase64;
  final Trabajador? trabajadorIdentificado;
  final List<ReconocimientoFacial> reconocimientos;
  final bool registroExitoso;
  final List<RegistroBiometrico> cachedFaces;
  final bool isInitialized;
  final File? imageFile;

  const ReconocimientoFacialStateData({
    this.estado = ReconocimientoFacialEstado.inicial,
    this.isLoading = false,
    this.errorMessage,
    this.imagenBase64,
    this.trabajadorIdentificado,
    this.reconocimientos = const [],
    this.registroExitoso = false,
    this.cachedFaces = const [],
    this.isInitialized = false,
    this.imageFile,
  });

  ReconocimientoFacialStateData copyWith({
    ReconocimientoFacialEstado? estado,
    bool? isLoading,
    String? errorMessage,
    String? imagenBase64,
    Trabajador? trabajadorIdentificado,
    List<ReconocimientoFacial>? reconocimientos,
    bool? registroExitoso,
    List<RegistroBiometrico>? cachedFaces,
    bool? isInitialized,
    File? imageFile,
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
      cachedFaces: cachedFaces ?? this.cachedFaces,
      isInitialized: isInitialized ?? this.isInitialized,
      imageFile: imageFile ?? this.imageFile,
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
      cachedFaces: cachedFaces,
      isInitialized: isInitialized,
      imageFile: imageFile,
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
    ref.watch(registroBiometricoRepositoryProvider),
    ref,
  );
});

class ReconocimientoFacialNotifier
    extends StateNotifier<ReconocimientoFacialStateData> {
  final IReconocimientoFacialRepository _repository;
  final NetworkInfo networkInfo;
  late Interpreter _interpreter;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(),
  );
  final IRegistroBiometricoRepository _biometricoRepository;
  final Ref ref;

  ReconocimientoFacialNotifier(
    this._repository,
    this.networkInfo,
    this._biometricoRepository,
    this.ref,
  ) : super(const ReconocimientoFacialStateData());

  Future<void> build() async {
    await initialize();
  }

  Future<void> initialize() async {
    reiniciarEstado();
    if (state.isInitialized) return;
    final interpreterOptions = InterpreterOptions();

    _interpreter = await Interpreter.fromAsset(
      'assets/mobilefacenet.tflite',
      options: interpreterOptions,
    );

    state = state.copyWith(isInitialized: true);
  }

  Future<void> cargarRegistrosBiometricos() async {
    final ubicacionId = ref.read(ubicacionNotifierProvider).ubicacion!.id;

    try {
      final registros = await _biometricoRepository.getFaces(ubicacionId);
      print("registros BIOMETRICOS");

      state = state.copyWith(cachedFaces: registros);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> setImagenFile(File imageFile) async {
    state = state.copyWith(imageFile: imageFile);
  }

  Future<void> setLoading(bool value) async {
    state = state.copyWith(isLoading: value);
  }

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

  Future<void> registerFace(
    int trabajadorId,
    List<double> embedding,
    XFile image,
    String imagenUrl,
  ) async {
    state = state.copyWith(
      isLoading: true,
      estado: ReconocimientoFacialEstado.capturando,
    );

    final faces = state.cachedFaces;

    final facesByTrabajador =
        faces.where((face) => face.trabajadorId == trabajadorId).toList();

    if (facesByTrabajador.length > 5) {
      state = state.copyWith(
        estado: ReconocimientoFacialEstado.error,
        isLoading: false,
        errorMessage: 'No puedes registrar más de 5 fotos',
      );
      return;
    }

    try {
      await _biometricoRepository.saveFace(
        trabajadorId,
        embedding,
        image,
        imagenUrl,
      );

      state = state.copyWith(
        estado: ReconocimientoFacialEstado.inicial,
        isLoading: false,
      );

      cargarRegistrosBiometricos();
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

    final horario = ref.read(horarioNotifierProvider).horario;

    if (horario == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay horario disponible',
        estado: ReconocimientoFacialEstado.error,
      );
      return;
    }

    final horaAprobadaId = horario.id;

    try {
      final exito = await _repository.registrarAsistenciaPorReconocimiento(
        state.trabajadorIdentificado!.equipoId,
        horaAprobadaId,
      );

      final exitoBool = exito == 'Asistencia registrada';

      state = state.copyWith(
        isLoading: false,
        registroExitoso: exitoBool,
        errorMessage: exitoBool ? null : exito,
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
    state = state.copyWith(
      estado: ReconocimientoFacialEstado.inicial,
      isLoading: false,
      errorMessage: null,
      trabajadorIdentificado: null,
    );
  }

  void cambiarEstado(ReconocimientoFacialEstado nuevoEstado) {
    state = state.copyWith(estado: nuevoEstado);
  }

  // Método para limpiar errores
  void clearErrors() {
    state = state.clearErrors();
  }

  List<double> getEmbedding(List input) {
    List output = List.generate(1, (_) => List.filled(192, 0));
    _interpreter.run(input, output);
    return output[0].cast<double>();
  }

  Future<String> identifyFace(
    List<double> embedding, bool shouldYouClockIn, {
    double threshold = 0.8,
  }) async {
    double minDistance = double.maxFinite;
    int trabajadorId = 0;

    final trabajadores = ref.read(trabajadorNotifierProvider).trabajadores;

    for (var face in state.cachedFaces) {
      final distance = _euclideanDistance(embedding, face.datosBiometricos);

      final validateDistance = distance <= threshold && distance < minDistance;

      if (validateDistance) {
        minDistance = distance;
        trabajadorId = face.trabajadorId;
      }
    }

    final Trabajador? trabajador = trabajadores.cast<Trabajador?>().firstWhere(
      (t) => t?.id == trabajadorId,
      orElse: () => null,
    );

    if (trabajador != null) {
      await ref
          .read(registroDiarioNotifierProvider.notifier)
          .tipoRegistroAsistencia(trabajador.equipoId);

      state = state.copyWith(
        trabajadorIdentificado: trabajador,
        isLoading: false,
        estado: ReconocimientoFacialEstado.exito,
      );

      if (!shouldYouClockIn) {
        return trabajador.nombre;
      }

      await registrarAsistenciaPorReconocimiento();
    }

    return trabajador?.nombre ?? 'No Registrado';
  }

  double _euclideanDistance(List e1, List e2) {
    if (e1.length != e2.length) {
      throw Exception('Vectors have different lengths');
    }
    var sum = 0.0;
    for (var i = 0; i < e1.length; i++) {
      sum += pow(e1[i] - e2[i], 2);
    }
    return sqrt(sum);
  }

  Future<void> deleteFace(int equipoId, String imagenUrl) async {

    final registroBiometrico = state.cachedFaces.firstWhere(
      (face) => face.blobFileString == imagenUrl,
    );

    await _biometricoRepository.deleteFace(equipoId, registroBiometrico.id);
    final ubicacionId = ref.read(ubicacionNotifierProvider).ubicacion!.id;

    state = state.copyWith(
      cachedFaces: await _biometricoRepository.getFaces(ubicacionId),
    );
  }

  Future<List<Face>> detectFaces(InputImage inputImage) async {
    final faces = await _faceDetector.processImage(inputImage);
    return faces;
  }

  @override
  void dispose() {
    if (!state.isInitialized) return;

    _faceDetector.close();

    _interpreter.close();

    state = state.copyWith(isInitialized: false);
  }

  static img.Image convertNV21ToImage(
    Uint8List nv21Data,
    int width,
    int height,
  ) {
    img.Image image = img.Image(width: width, height: height);
    final ySize = width * height;
    final uvSize = width * height ~/ 4;

    final yPlane = nv21Data.sublist(0, ySize);
    final uvPlane = nv21Data.sublist(ySize, ySize + uvSize * 2);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final yIndex = y * width + x;
        final yValue = yPlane[yIndex];

        final uvIndex = (y ~/ 2) * width + (x - (x % 2));
        final vValue = uvPlane[uvIndex];
        final uValue = uvPlane[uvIndex + 1];

        final r = (yValue + 1.402 * (vValue - 128)).clamp(0, 255).toInt();
        final g =
            (yValue - 0.34414 * (uValue - 128) - 0.71414 * (vValue - 128))
                .clamp(0, 255)
                .toInt();
        final b = (yValue + 1.772 * (uValue - 128)).clamp(0, 255).toInt();

        image.setPixel(x, y, img.ColorRgb8(r, g, b));
      }
    }

    return image;
  }
}
