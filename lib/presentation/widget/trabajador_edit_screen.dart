import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities.dart';
import '../providers/use_case.dart';

class TrabajadorEditScreen extends ConsumerStatefulWidget {
  final Trabajador? trabajador;

  const TrabajadorEditScreen({super.key, this.trabajador});

  @override
  ConsumerState<TrabajadorEditScreen> createState() =>
      _TrabajadorEditScreenState();
}

class _TrabajadorEditScreenState extends ConsumerState<TrabajadorEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _cedulaController;
  late TextEditingController _apellidoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.trabajador?.nombre);
    _cedulaController = TextEditingController(
      text: widget.trabajador?.id.toString(),
    );
    _apellidoController = TextEditingController(
      text: widget.trabajador?.primerApellido,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.trabajador != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Trabajador' : 'Nuevo Trabajador'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator:
                    (value) => value?.isEmpty ?? true ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _cedulaController,
                decoration: const InputDecoration(labelText: 'Cédula'),
                validator: (value) => _validateCedula(value),
              ),
              TextFormField(
                controller: _apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator:
                    (value) => value?.isEmpty ?? true ? 'Requerido' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateCedula(String? value) {
    // Lógica de validación de cédula
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final trabajador = Trabajador(
        nombre: _nombreController.text,
        primerApellido: _apellidoController.text,
        segundoApellido: _apellidoController.text,
        equipoId: widget.trabajador?.equipoId ?? 0,
        // ...otros campos
      );

      await ref
          .read(trabajadoresNotifierProvider.notifier)
          .agregarTrabajador(trabajador);

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
