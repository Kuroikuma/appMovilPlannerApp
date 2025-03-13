abstract class BaseHybridRepository {
  final bool isConnected; // Inyectar desde un NetworkChecker

  const BaseHybridRepository(this.isConnected);

  Future<void> syncLocalWithRemote();
  Future<void> handleOfflineOperations();
}
