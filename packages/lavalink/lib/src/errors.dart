class LavalinkException implements Exception {
  final DateTime timestamp;
  final int status;
  final String error;
  final String? trace;
  final String message;
  final String path;

  LavalinkException({
    required this.timestamp,
    required this.status,
    required this.error,
    required this.trace,
    required this.message,
    required this.path,
  });

  @override
  String toString() => 'LavalinkException: $error ($status): $message';
}
