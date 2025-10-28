/// An exception thrown when a Lavalink API call returns an error.
class LavalinkException implements Exception {
  /// The time at which the error occurred.
  final DateTime timestamp;

  /// The HTTP status code of the response.
  final int status;

  /// The name of the error.
  final String error;

  /// The stack trace at which the error occurred in the Lavalink server.
  final String? trace;

  /// A description of the error.
  final String message;

  /// The endpoint in which the error occurred.
  final String path;

  /// Create a new [LavalinkException].
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
