import 'package:riverpod/riverpod.dart';

import '../../../data/database.dart';
import '../../../domain/entities.dart';

import '../../../domain/repositories.dart';
import '../repositories.dart';

final syncEntityNotifierProvider =
    StateNotifierProvider<SyncEntityNotifier, AsyncValue<List<SyncEntity>>>(
      (ref) => SyncEntityNotifier(ref.watch(syncEntityRepoProvider)),
    );

class SyncEntityNotifier extends StateNotifier<AsyncValue<List<SyncEntity>>> {
  final ISyncEntityRepository _repository;

  SyncEntityNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadSyncEntity() async {
    try {
      print('🔄 Iniciando sincronización automática');

    // Paso 1: Primero descargar cambios del servidor
    await syncLocalWithRemoteData();

    // Paso 2: Luego enviar cambios locales pendientes
    await syncRemoteWithLocalData();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> syncRemoteWithLocalData() async {
    try {
      await _repository.syncRemoteWithLocalData();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> syncLocalWithRemoteData() async {
    try {
      await _repository.syncLocalWithRemoteData();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> markMultipleAsSynced(List<SyncEntity> operations) async {
    try {
      await _repository.markMultipleAsSynced(operations);
      await loadSyncEntity();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> insertSyncEntity(SyncsEntitysCompanion syncEntity) async {
    try {
      await _repository.insertSyncEntity(syncEntity);
      await loadSyncEntity();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
