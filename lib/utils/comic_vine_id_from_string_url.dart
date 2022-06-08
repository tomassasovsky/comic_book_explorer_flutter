/// Helper method to get the ID from a Comic Vine URL.
extension ComicVineIdFromStringUrl on String? {
  /// Gets the ID from a Comic Vine URL.
  String? get comicVineId {
    if (this == null) return null;

    final uri = Uri.parse(this!);
    final pathSegments = uri.pathSegments;
    if (pathSegments.isEmpty) {
      return null;
    }
    return pathSegments[pathSegments.length - 2];
  }
}
