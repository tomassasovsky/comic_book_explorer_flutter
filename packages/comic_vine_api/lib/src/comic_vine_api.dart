import 'dart:math' as math;

import 'package:comic_vine_api/src/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// {@template comic_vine_api}
/// A wrapper for the Comic Vine RestAPI.
/// {@endtemplate}
class ComicVineApi {
  /// {@macro comic_vine_api}
  const ComicVineApi({
    required this.apiKey,
    required http.Client httpClient,
  }) : _httpClient = httpClient;

  /// The host URL used for all API requests.
  ///
  /// Only exposed for testing purposes. Do not use directly.
  @visibleForTesting
  static const String authority = 'comicvine.com';

  final http.Client _httpClient;

  /// The API key used for all API requests.
  ///
  /// Only exposed for testing purposes. Do not use directly.
  @visibleForTesting
  final String apiKey;

  /// Gets a list of Comic Vine issues.
  Future<ComicVineGenericResponse<ComicVineIssue>> getIssues({
    int limit = 100,
    int offset = 0,
  }) async {
    // the API only supports 100 results per page,
    // so we limit to that no matter what.
    final _limit = math.min(limit, 100);

    final url = Uri.https(
      authority,
      '/api/issues/',
      <String, String>{
        'format': 'json',
        'api_key': apiKey,
        'limit': _limit.toString(),
        'offset': offset.toString(),
      },
    );

    final response = await _httpClient.get(url);

    final result = ComicVineGenericResponse<ComicVineIssue>.fromJson(
      ComicVineIssue.fromMap,
      response.body,
    );

    return result;
  }

  /// Gets a list of Comic Vine issues.
  Future<ComicVineGenericResponse<ComicVineIssue>> getIssueDetails(
    String issueId,
  ) async {
    assert(issueId.isNotEmpty, 'issueId cannot be empty');

    final url = Uri.https(
      authority,
      '/api/issue/$issueId',
      <String, String>{
        'format': 'json',
        'api_key': apiKey,
      },
    );

    final response = await _httpClient.get(url);

    final result = ComicVineGenericResponse<ComicVineIssue>.fromJson(
      ComicVineIssue.fromMap,
      response.body,
    );

    return result;
  }

  /// Gets the list of images for a given character.
  Future<ComicVineGenericResponse<ComicVineImageResponse>> getImage(
    ComicVineImageResource imageResource,
    String id,
  ) async {
    assert(id.isNotEmpty, 'id cannot be empty');

    final url = Uri.https(
      authority,
      '/api/${imageResource.name}/$id',
      <String, String>{
        'format': 'json',
        'api_key': apiKey,
        'field_list': 'image,name',
      },
    );

    final response = await _httpClient.get(url);

    final result = ComicVineGenericResponse<ComicVineImageResponse>.fromJson(
      ComicVineImageResponse.fromMap,
      response.body,
    );

    return result;
  }
}

/// A class to make it easier to handle the response from the API.
extension Result on http.Response {
  /// Returns true if the response is a success.
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Returns true if the response is a failure.
  bool get isFailure => !isSuccess;
}
