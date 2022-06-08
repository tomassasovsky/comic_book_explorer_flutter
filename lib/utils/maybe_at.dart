/// Tries to find an object in the index specified, and returns it if found.
/// If the object is not found, returns [Null].
extension MaybeAt<T> on Iterable<T> {
  /// Tries to find an object in the index specified, and returns it if found.
  /// If the object is not found, returns [Null].
  T? maybeAt(int index) {
    try {
      if (T is String) {
        return ((elementAt(index) as String?)?.isNotEmpty ?? false)
            ? elementAt(index)
            : null;
      }
      return elementAt(index);
    } catch (_) {}
    return null;
  }
}
