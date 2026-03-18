class ServerException implements Exception {
  String message;
  ServerException([
    this.message = "An unexpected error occurred. Please try again later.",
  ]);
}

class CacheException implements Exception {
  String message;
  CacheException([
    this.message =
        "An unexpected error occurred while accessing local data. Please try again.",
  ]);
}

class NetworkException implements Exception {
  String message;
  NetworkException([
    this.message =
        "An unexpected error occurred. Please check your internet connection and try again.",
  ]);
}
