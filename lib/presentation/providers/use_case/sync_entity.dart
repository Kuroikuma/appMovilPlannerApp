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

  SyncEntityNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadSyncEntity();
  }

  Future<void> _loadSyncEntity() async {
    try {
      final syncEntity = await _repository.getPendingLocalSyncOperations();
      state = AsyncValue.data(syncEntity);
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
      await _loadSyncEntity();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> insertSyncEntity(SyncsEntitysCompanion syncEntity) async {
    try {
      await _repository.insertSyncEntity(syncEntity);
      await _loadSyncEntity();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
