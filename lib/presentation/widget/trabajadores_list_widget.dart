import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/use_case.dart';
import 'trabajador_edit_screen.dart';
import 'trabajador_item.dart';
import 'error_view.dart';

class TrabajadoresList extends ConsumerWidget {
  const TrabajadoresList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trabajadoresAsync = ref.watch(trabajadoresNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Trabajadores"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(trabajadoresNotifierProvider);
            },
          ),
        ],
      ),
      body: trabajadoresAsync.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => ErrorView(error: error),
        data: (trabajadores) {
          if (trabajadores.isEmpty) {
            return const Center(
              child: Text(
                'No hay trabajadores registrados',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }
          return ListView.builder(
            itemCount: trabajadores.length,
            itemBuilder:
                (context, index) => TrabajadorItem(trabajadores[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => const TrabajadorEditScreen()),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
