/// {@template comic_vine_result}
/// The result of a Comic Vine API request.
/// {@endtemplate}
enum ComicVineResult {
  /// {@macro comic_vine_result}
  /// When the API returns a successful response.
  ok(1),

  /// {@macro comic_vine_result}
  /// When the API Key is invalid.
  invalidApiKey(100),

  /// {@macro comic_vine_result}
  /// When the request did not find a matching resource.
  objectNotFound(101),

  /// {@macro comic_vine_result}
  /// When the request URL was invalid.
  errorInUrlFormat(102),

  /// {@macro comic_vine_result}
  // ignore: lines_longer_than_80_chars
  // TODO(tomassasovsky): Figure out what `'jsonp' format requires a 'json_callback' argument` means.
  requiresJsonCallback(103),

  /// {@macro comic_vine_result}
  /// When the filtering was not made properly.
  filterError(104),

  /// {@macro comic_vine_result}
  /// When the API Key used does not have access to the requested resource.
  /// This means that the API Key is valid, but the user is not a subscriber.
  subscribersOnly(105),

  /// {@macro comic_vine_result}
  unknownError(0);

  /// {@macro comic_vine_result}
  const ComicVineResult(this.value);

  /// {@macro comic_vine_result}
  /// The value of the result.
  factory ComicVineResult.fromValue(int value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => ComicVineResult.unknownError,
    );
  }

  /// The value of the result.
  final int value;
}
