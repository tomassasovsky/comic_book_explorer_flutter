import 'package:equatable/equatable.dart';

/// {@template comic_vine_volume}
/// A Volume model, found in the [ComicVineVolume] model.
/// {@endtemplate}
class ComicVineVolume extends Equatable {
  /// {@macro comic_vine_volume}
  const ComicVineVolume({
    this.apiDetailUrl,
    this.id,
    this.name,
    this.siteDetailUrl,
    this.count,
  });

  /// {@macro comic_vine_volume}
  /// A parser for the Volume model.
  /// Accepts a JSON Map and returns an [ComicVineVolume] object.
  factory ComicVineVolume.fromMap(Map map) {
    map = map.cast<String, dynamic>();
    return ComicVineVolume(
      apiDetailUrl: map['api_detail_url'] as String?,
      id: map['id'] as int?,
      name: map['name'] as String?,
      siteDetailUrl: map['site_detail_url'] as String?,
      count: map['count'] as int?,
    );
  }

  /// The URL of the API detail of the volume.
  final String? apiDetailUrl;

  /// Unique ID of the volume.
  final int? id;

  /// Name of the volume.
  final String? name;

  /// URL pointing to the volume on Giant Bomb.
  final String? siteDetailUrl;

  /// The number of issues in the volume.
  final int? count;

  /// {@macro comic_vine_volume}
  /// Convert this object to a JSON map.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'api_detail_url': apiDetailUrl,
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (siteDetailUrl != null) 'site_detail_url': siteDetailUrl,
        if (count != null) 'count': count,
      };

  @override
  String toString() {
    return '''
    IssueVolume(
      apiDetailUrl: $apiDetailUrl,
      id: $id,
      name: $name,
      siteDetailUrl: $siteDetailUrl,
      count: $count
    )
    ''';
  }

  @override
  List<Object?> get props {
    return [
      apiDetailUrl,
      id,
      name,
      siteDetailUrl,
      count,
    ];
  }
}
