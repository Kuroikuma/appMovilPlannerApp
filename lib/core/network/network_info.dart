import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    final status = await connectionChecker.connectionStatus;
    print("Estado de conexión: ${status == InternetConnectionStatus.connected} $status");
    return status == InternetConnectionStatus.connected;
  }
}
