import 'package:flutter/material.dart';
import '../screens/configurar_ubicacion_screen.dart';
import '../screens/main_screen.dart';
import '../screens/trabajador_screen.dart';
import '../screens/ubicacion_screen.dart';

class AppRoutes {
  static const String ubicacion = '/ubicacion';
  static const String trabajadores = '/trabajadores';
  static const String configurarUbicacion = '/configurar_ubicacion';
  static const String main = '/';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      main: (context) => const MainScreen(),
      ubicacion: (context) => const UbicacionScreen(),
      trabajadores: (context) => const TrabajadoresScreen(),
      configurarUbicacion: (context) => const ConfigurarUbicacionScreen(),
    };
  }
}
