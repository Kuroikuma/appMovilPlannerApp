import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/use_case/ubicacion.dart';

class ConfiurarUbicacionFormScreen extends ConsumerStatefulWidget {
  const ConfiurarUbicacionFormScreen({super.key});

  @override
  ConsumerState<ConfiurarUbicacionFormScreen> createState() =>
      _ConfiurarUbicacionFormScreenState();
}

class _ConfiurarUbicacionFormScreenState
    extends ConsumerState<ConfiurarUbicacionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codigoUbicacionController;

  @override
  void initState() {
    super.initState();
    _codigoUbicacionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _codigoUbicacionController,
                decoration: const InputDecoration(
                  labelText: 'Código de Ubicación',
                ),
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

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref
          .read(ubicacionNotifierProvider.notifier)
          .obtenerUbicacionId(_codigoUbicacionController.text);

      await ref
          .read(ubicacionNotifierProvider.notifier)
          .configurarUbicacion(_codigoUbicacionController.text);

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
