import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities.dart';

class TrabajadorDetailScreen extends ConsumerWidget {
  final Trabajador trabajador;

  const TrabajadorDetailScreen({super.key, required this.trabajador});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Trabajador')),
      body: _DetailContent(trabajador: trabajador),
    );
  }
}

class _DetailContent extends StatelessWidget {
  final Trabajador trabajador;

  const _DetailContent({required this.trabajador});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nombre: ${trabajador.nombre}'),
          Text('Cédula: ${trabajador.cedula}'),
          // Más campos...
        ],
      ),
    );
  }
}
