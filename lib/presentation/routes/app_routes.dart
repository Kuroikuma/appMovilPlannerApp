import 'package:flutter/material.dart';
import '../screens/configurar_ubicacion_screen.dart';
import '../screens/face_recognition_screen.dart';
import '../screens/main_screen.dart';
import '../screens/reconocimiento_facial_screen.dart';
import '../screens/registro_asistencia_screen.dart';
import '../screens/trabajador_screen.dart';
import '../screens/ubicacion_screen.dart';

class AppRoutes {
  static const String ubicacion = '/ubicacion';
  static const String trabajadores = '/trabajadores';
  static const String configurarUbicacion = '/configurar_ubicacion';
  static const String registroAsistencia = '/registro-asistencia';
  static const String main = '/';
  static const String reconocimientoFacial = '/reconocimiento-facial';
  static const String faceRecognition = '/face-recognition';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      main: (context) => const MainScreen(),
      ubicacion: (context) => const UbicacionScreen(),
      trabajadores: (context) => const TrabajadoresScreen(),
      configurarUbicacion: (context) => const ConfigurarUbicacionScreen(),
      registroAsistencia: (context) => const RegistroAsistenciaScreen(),
      reconocimientoFacial: (context) => const ReconocimientoFacialScreen(),
      faceRecognition: (context) => const FaceRecognitionScreen(),
    };
  }
}
