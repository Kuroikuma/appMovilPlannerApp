class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = "Error de red"]);

  @override
  String toString() => "NetworkException: $message";
}

class ApiException implements Exception {
  final String message;
  ApiException([this.message = "Error en la API"]);

  @override
  String toString() => "ApiException: $message";
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = "Error de caché"]);

  @override
  String toString() => "CacheException: $message";
}

class NoInternetException implements Exception {
  final String message;
  NoInternetException([this.message = "No hay conexión a Internet"]);

  @override
  String toString() => "NoInternetException: $message";
}

class NoInternetUbicacionException implements Exception {
  final String message;
  NoInternetUbicacionException([
    this.message = "No hay conexión a Internet para configurar la ubicación",
  ]);

  @override
  String toString() => "NoInternetUbicacionException: $message";
}

class CustomException implements Exception {
  final String message;
  CustomException([this.message = "Error desconocido"]);

  @override
  String toString() => "Advertencia: $message";
}
