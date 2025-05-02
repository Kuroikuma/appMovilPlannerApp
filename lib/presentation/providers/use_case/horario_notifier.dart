import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database.dart';
import '../../../domain/repositories/i_horario_repositorio.dart';
import '../repositories.dart';

class HorarioState {
  final Horario? horario;

  const HorarioState({this.horario});

  HorarioState copyWith({Horario? horario}) {
    return HorarioState(horario: horario ?? this.horario);
  }
}

final horarioNotifierProvider =
    StateNotifierProvider<HorarioNotifier, HorarioState>((ref) {
      return HorarioNotifier(ref.watch(horarioRepositoryProvider));
    });

class HorarioNotifier extends StateNotifier<HorarioState> {
  final IHorarioRepository _repository;

  HorarioNotifier(this._repository) : super(const HorarioState());

  Future<void> cargarHorarios(String ubicacionId) async {
    final horarios = await _repository.obtenerTodos(ubicacionId);
    state = state.copyWith(horario: horarios);
  }

  Future<void> agregarHorario(Horario horario) async {
    await _repository.insertar(horario);
    await cargarHorarios(horario.ubicacionId.toString());
  }

  Future<void> actualizarHorario(Horario horario) async {
    await _repository.actualizar(horario);
    await cargarHorarios(horario.ubicacionId.toString());
  }

  Future<void> eliminarHorario(int id) async {
    await _repository.eliminar(id);
    await cargarHorarios(id.toString());
  }

  Future<Horario?> obtenerHorarioPorId(int id) async {
    return await _repository.obtenerPorId(id);
  }
}
