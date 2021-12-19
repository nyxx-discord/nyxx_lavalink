/// An exception that can be thrown when using
/// [Node.searchTracks] or [Node.autoSearch] if the request fails
class HttpException implements Exception {
  /// The status code of the request
  final int code;

  HttpException(this.code);

  @override
  String toString() => "Lavalink server responded with $code code";
}
