import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter_application_1/domain/repositories/i_registro_biometrico_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/entities.dart';
import '../../../domain/models/reconocimiento_facial.dart';
import '../../../domain/models/registro_biometrico.dart';
import '../../../domain/repositories/i_reconocimiento_facial_repository.dart';
import '../providers.dart';
import '../repositories.dart';
import 'ubicacion.dart';

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
  final List<RegistroBiometrico> cachedFaces;
  final bool isInitialized;

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
    if (state.isInitialized) return;
    final interpreterOptions = InterpreterOptions();

    _interpreter = await Interpreter.fromAsset(
      'assets/mobilefacenet.tflite',
      options: interpreterOptions,
    );

    final codigoUbicacon =
        ref.read(ubicacionNotifierProvider).ubicacion!.codigoUbicacion;
    final codigoLocal = ref.read(ubicacionNotifierProvider).ubicacion!.id;

    print('codigoLocal: $codigoLocal');

    state = state.copyWith(
      cachedFaces: await _biometricoRepository.getFaces(codigoUbicacon),
      isInitialized: true,
    );
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
    int equipoId,
    List<double> embedding,
    XFile image,
    String imagenUrl,
  ) async {
    print('registerFace');
    state = state.copyWith(
      isLoading: true,
      estado: ReconocimientoFacialEstado.capturando,
    );

    try {
      final registroBiometrico = await _biometricoRepository.saveFace(
        equipoId,
        embedding,
        image,
        imagenUrl,
      );

      final cachedNewFaces = state.cachedFaces;
      cachedNewFaces.add(registroBiometrico);

      state = state.copyWith(
        estado: ReconocimientoFacialEstado.exito,
        isLoading: false,
        cachedFaces: cachedNewFaces,
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

  //detecttor de rostros app vieja
  List prepareInputFromNV21(Map<String, dynamic> params) {
    final nv21Data = params['nv21Data'] as Uint8List;
    final width = params['width'] as int;
    final height = params['height'] as int;
    final isFrontCamera = params['isFrontCamera'] as bool;
    final face = params['face'] as Face;

    img.Image image = convertNV21ToImage(nv21Data, width, height);
    image = img.copyRotate(image, angle: isFrontCamera ? -90 : 90);

    return prepareInput(image, face);
  }

  List prepareInputFromImagePath(Map<String, dynamic> params) {
    final imgPath = params['imgPath'] as String;
    final face = params['face'] as Face;

    img.Image image = img.decodeImage(File(imgPath).readAsBytesSync())!;
    return prepareInput(image, face);
  }

  static List prepareInput(img.Image image, Face face) {
    int x, y, w, h;
    x = face.boundingBox.left.round();
    y = face.boundingBox.top.round();
    w = face.boundingBox.width.round();
    h = face.boundingBox.height.round();

    img.Image faceImage = img.copyCrop(image, x: x, y: y, width: w, height: h);
    img.Image resizedImage = img.copyResizeCropSquare(faceImage, size: 112);

    // Save cropped face image
    // final docDir = await getApplicationDocumentsDirectory();
    // final file = File('${docDir.path}/${face.hashCode}.jpg');
    // await file.writeAsBytes(img.encodeJpg(resizedImage));

    List input = _imageToByteListFloat32(resizedImage, 112, 127.5, 127.5);
    input = input.reshape([1, 112, 112, 3]);

    return input;
  }

  List<double> getEmbedding(List input) {
    List output = List.generate(1, (_) => List.filled(192, 0));
    print('esta es la parte del interprete');
    print(state.isInitialized);
    _interpreter.run(input, output);
    return output[0].cast<double>();
  }

  static List _imageToByteListFloat32(
    img.Image image,
    int size,
    double mean,
    double std,
  ) {
    var convertedBytes = Float32List(1 * size * size * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < size; i++) {
      for (var j = 0; j < size; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (pixel.r - mean) / std;
        buffer[pixelIndex++] = (pixel.g - mean) / std;
        buffer[pixelIndex++] = (pixel.b - mean) / std;
      }
    }
    return convertedBytes.toList();
  }

  Future<String> identifyFace(
    List<double> embedding, {
    double threshold = 0.8,
  }) async {
    double minDistance = double.maxFinite;
    String name = 'Kaun hai re tu?'; // Unknown

    for (var face in state.cachedFaces) {
      final distance = _euclideanDistance(embedding, face.datosBiometricos);

      if (distance <= threshold && distance < minDistance) {
        minDistance = distance;
        name = face.trabajadorId.toString();
      }
    }

    return name;
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

  Future<void> deleteFace(int equipoId, String registroBiometricoId) async {
    await _biometricoRepository.deleteFace(equipoId, registroBiometricoId);
    final codigoUbicacon =
        ref.read(ubicacionNotifierProvider).ubicacion!.codigoUbicacion;

    state = state.copyWith(
      cachedFaces: await _biometricoRepository.getFaces(codigoUbicacon),
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
