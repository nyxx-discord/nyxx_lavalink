/// An exception related to cluster functions
class ClusterException implements Exception {
  /// The actual error description
  final String error;

  ClusterException(this.error);

  @override
  String toString() => "Lavalink cluster error: $error";
}
