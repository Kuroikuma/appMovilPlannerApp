import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

import '../../../domain/entities.dart';
import '../../../domain/models/reconocimiento_facial.dart';
import '../../../domain/repositories/i_reconocimiento_facial_repository.dart';
import '../../../domain/repositories/i_registro_diario_repository.dart';

class ReconocimientoFacialRepository
    implements IReconocimientoFacialRepository {
  final IRegistroDiarioRepository _registroDiarioRepository;

  // Datos de ejemplo para demostración
  final List<ReconocimientoFacial> _reconocimientosDemo = [
    ReconocimientoFacial(
      id: '1',
      trabajadorId: '1',
      imagenUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      confianza: 0.95,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 30)),
    ),
    ReconocimientoFacial(
      id: '2',
      trabajadorId: '2',
      imagenUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      confianza: 0.92,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 25)),
    ),
    ReconocimientoFacial(
      id: '3',
      trabajadorId: '3',
      imagenUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      confianza: 0.88,
      fechaCreacion: DateTime.now().subtract(const Duration(days: 20)),
    ),
  ];

  // Datos de ejemplo de trabajadores
  final List<Trabajador> _trabajadoresDemo = [
    Trabajador(
      id: 1,
      nombre: 'Juan',
      equipoId: 8,
      primerApellido: 'Pérez',
      segundoApellido: 'González',
      fotoUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      cargo: 'Jefe de Proyecto',
      faceSync: true,
      estado: true,
      identificacion: '12345678',
    ),
    Trabajador(
      id: 2,
      nombre: 'María',
      primerApellido: 'González',
      segundoApellido: 'Rodríguez',
      equipoId: 8,
      faceSync: true,
      estado: true,
      fotoUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      cargo: 'Jefe de Proyecto',
      identificacion: '12345678',
    ),
    Trabajador(
      id: 3,
      nombre: 'Carlos',
      primerApellido: 'Rodríguez',
      segundoApellido: 'González',
      equipoId: 8,
      faceSync: true,
      estado: true,
      fotoUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      cargo: 'Jefe de Proyecto',
      identificacion: '12345678',
    ),
  ];

  ReconocimientoFacialRepository(this._registroDiarioRepository);

  @override
  Future<List<ReconocimientoFacial>> obtenerReconocimientosPorTrabajador(
    String trabajadorId,
  ) async {
    // Simular una llamada a la API
    await Future.delayed(const Duration(seconds: 1));

    return _reconocimientosDemo
        .where((reconocimiento) => reconocimiento.trabajadorId == trabajadorId)
        .toList();
  }

  @override
  Future<ReconocimientoFacial> registrarReconocimientoFacial(
    String trabajadorId,
    String imagenBase64,
  ) async {
    // Simular una llamada a la API
    await Future.delayed(const Duration(seconds: 2));

    // En una implementación real, aquí se enviaría la imagen al servidor
    // para procesarla y almacenarla

    // Crear un nuevo reconocimiento facial (simulado)
    final nuevoReconocimiento = ReconocimientoFacial(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      trabajadorId: trabajadorId,
      imagenUrl: _obtenerUrlTrabajador(trabajadorId),
      confianza: 0.9 + (Random().nextDouble() * 0.1), // Entre 0.9 y 1.0
      fechaCreacion: DateTime.now(),
    );

    // En una implementación real, aquí se guardaría en la base de datos
    _reconocimientosDemo.add(nuevoReconocimiento);

    return nuevoReconocimiento;
  }

  @override
  Future<Trabajador?> identificarTrabajador(String imagenBase64) async {
    // Simular una llamada a la API
    await Future.delayed(const Duration(seconds: 3));

    // En una implementación real, aquí se enviaría la imagen al servidor
    // para procesarla y compararla con las imágenes almacenadas

    // Para la demostración, devolvemos un trabajador aleatorio
    final random = Random();
    if (random.nextDouble() > 0.2) {
      // 80% de probabilidad de éxito
      return _trabajadoresDemo[random.nextInt(_trabajadoresDemo.length)];
    } else {
      return null; // No se identificó ningún trabajador
    }
  }

  @override
  Future<bool> registrarAsistenciaPorReconocimiento(String trabajadorId) async {
    try {
      // Convertir el ID de string a int
      final equipoId = int.tryParse(trabajadorId);
      if (equipoId == null) {
        return false;
      }

      // Registrar la entrada
      await _registroDiarioRepository.registrarEntrada(
        equipoId,
        registroBiometricoId: 'facial_${DateTime.now().millisecondsSinceEpoch}',
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> eliminarReconocimientoFacial(String reconocimientoId) async {
    // Simular una llamada a la API
    await Future.delayed(const Duration(seconds: 1));

    try {
      final index = _reconocimientosDemo.indexWhere(
        (r) => r.id == reconocimientoId,
      );
      if (index != -1) {
        _reconocimientosDemo.removeAt(index);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Método auxiliar para obtener la URL de la foto del trabajador
  String _obtenerUrlTrabajador(String trabajadorId) {
    try {
      return _trabajadoresDemo
              .firstWhere((t) => t.id == trabajadorId)
              .fotoUrl ??
          'https://randomuser.me/api/portraits/lego/1.jpg';
    } catch (e) {
      return 'https://randomuser.me/api/portraits/lego/1.jpg';
    }
  }
}
