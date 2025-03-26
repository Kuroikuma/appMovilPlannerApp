import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities.dart';

import 'trabajador_detail.dart';

class TrabajadorItem extends StatelessWidget {
  final Trabajador trabajador;

  const TrabajadorItem(this.trabajador, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${trabajador.nombre} ${trabajador.primerApellido}'),
        subtitle: Text(trabajador.id.toString()),
        trailing: Icon(
          trabajador.faceSync ? Icons.check_circle : Icons.cancel,
          color: trabajador.faceSync ? Colors.green : Colors.red,
        ),
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (ctx) => TrabajadorDetailScreen(trabajador: trabajador),
              ),
            ),
      ),
    );
  }
}
