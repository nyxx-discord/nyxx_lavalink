/// A exception object that can be sent by lavalink at certain endpoints
abstract class ILavalinkException {
  /// Exception message
  String? get message;

  /// The error message
  String? get error;

  /// The cause of the exception
  String? get cause;

  /// Exception severity
  String? get severity;
}

/// A exception object that can be sent by lavalink at certain endpoints
class LavalinkException implements ILavalinkException {
  /// Exception message
  @override
  late final String? message;

  /// The error message
  @override
  late final String? error;

  /// The cause of the exception
  @override
  late final String? cause;

  /// Exception severity
  @override
  late final String? severity;

  LavalinkException(Map<String, dynamic> json) {
    if (json.containsKey("exception")) {
      message = json["exception"]["message"] as String?;
      severity = json["exception"]["severity"] as String?;
      cause = json["exception"]["cause"] as String?;
    } else {
      error = json["error"] as String?;
    }
  }
}
