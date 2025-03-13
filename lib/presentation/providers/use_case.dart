import 'package:riverpod/riverpod.dart';

import '../../domain/entities.dart';
import '../../domain/repositories.dart';
import 'repositories.dart';

final trabajadoresNotifierProvider =
    StateNotifierProvider<TrabajadoresNotifier, AsyncValue<List<Trabajador>>>(
      (ref) => TrabajadoresNotifier(ref.watch(trabajadorRepositoryProvider)),
    );

class TrabajadoresNotifier extends StateNotifier<AsyncValue<List<Trabajador>>> {
  final ITrabajadorRepository _repository;

  TrabajadoresNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadTrabajadores(); // Carga inicial
  }

  Future<void> _loadTrabajadores() async {
    try {
      final trabajadores = await _repository.obtenerTodosTrabajadores();
      state = AsyncValue.data(trabajadores);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // ✅ Agregar un nuevo trabajador sin recargar todo
  Future<void> agregarTrabajador(Trabajador trabajador) async {
    try {
      await _repository.crearTrabajador(trabajador);
      state = state.whenData((trabajadores) => [...trabajadores, trabajador]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
