import 'dart:convert';

import 'package:comic_vine_api/src/models/generic_response_result.dart';
import 'package:equatable/equatable.dart';

/// {@template comic_vine_generic_response}
/// A generic response from the Comic Vine API.
/// {@endtemplate}
class ComicVineGenericResponse<T> extends Equatable {
  /// {@macro comic_vine_generic_response}
  const ComicVineGenericResponse({
    required this.error,
    required this.limit,
    required this.offset,
    required this.pageResults,
    required this.totalResults,
    required this.statusCode,
    required this.items,
    required this.version,
  });

  /// {@macro comic_vine_generic_response}
  /// A parser for the Comic Vine API response.
  /// Accepts a JSON Map and returns a [ComicVineGenericResponse] object.
  factory ComicVineGenericResponse.fromMap(
    T Function(Map map) itemParser,
    Map map,
  ) {
    // make sure we're dealing with a JSON map
    map = map.cast<String, dynamic>();

    // extract the results from the map
    late final List<Map> items;
    if (map['results'] is List) {
      items = (map['results'] as List).cast<Map>();
    } else if (map['results'] is Map) {
      items = <Map>[map['results'] as Map];
    }

    // parse the results into a list of objects
    final parsedItems = items.map(itemParser).toList();

    return ComicVineGenericResponse(
      error: map['error'] as String,
      limit: (map['limit'] as int?) ?? 0,
      offset: (map['offset'] as int?) ?? 0,
      pageResults: (map['number_of_page_results'] as int?) ?? 0,
      totalResults: (map['number_of_total_results'] as int?) ?? 0,
      statusCode: (map['status_code'] as int?) ?? 0,
      items: parsedItems,
      version: map['version'] as String? ?? '',
    );
  }

  /// {@macro comic_vine_generic_response}
  /// A parser for the Comic Vine API response.
  /// Accepts a JSON String and returns a [ComicVineGenericResponse] object.
  factory ComicVineGenericResponse.fromJson(
    T Function(Map map) itemParser,
    String source,
  ) =>
      ComicVineGenericResponse.fromMap(
        itemParser,
        json.decode(source) as Map,
      );

  /// {@macro comic_vine_generic_response}
  /// Convert this object to a JSON map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'limit': limit,
      'offset': offset,
      'number_of_page_results': pageResults,
      'number_of_total_results': totalResults,
      'status_code': statusCode,
      'results': items,
      'version': version,
    };
  }

  /// {@macro comic_vine_generic_response}
  /// Convert this object to a JSON string.
  String toJson() => json.encode(toMap());

  /// A text string representing the status_code.
  final String error;

  /// The value of the limit filter specified, or 100 if not specified.
  final int limit;

  /// The value of the offset filter specified, or 0 if not specified.
  final int offset;

  /// The number of results on this page.
  final int pageResults;

  /// The number of total results matching the filter conditions specified.
  final int totalResults;

  /// An integer indicating the result of the request. Acceptable values are:
  /// 1:   OK
  /// 100: Invalid API Key
  /// 101: Object Not Found
  /// 102: Error in URL Format
  /// 103: 'jsonp' format requires a 'json_callback' argument
  /// 104: Filter Error
  /// 105: Subscriber only video is for subscribers only
  final int statusCode;

  /// Zero or more items that match the filters specified.
  final List<T> items;

  /// The version of the API used to generate the response.
  final String version;

  /// To recognise if the response is an error or not,
  /// and if it is, what kind of error it is.
  ComicVineResult get result => ComicVineResult.fromValue(statusCode);

  @override
  String toString() {
    return '''
    ComicVineGenericResponse(
      error: $error,
      limit: $limit,
      offset: $offset,
      pageResults: $pageResults,
      totalResults: $totalResults,
      statusCode: $statusCode,
      results: $items,
      version: $version
    )
    ''';
  }

  @override
  List<Object?> get props {
    return [
      error,
      limit,
      offset,
      pageResults,
      totalResults,
      statusCode,
      items,
      version,
    ];
  }
}
