import 'package:comic_vine_api/src/models/models.dart';
import 'package:equatable/equatable.dart';

/// {@template comic_vine_issue}
/// An Issue model for the Comic Vine API.
/// {@endtemplate}
class ComicVineIssue extends Equatable {
  /// {@macro comic_vine_issue}
  const ComicVineIssue({
    this.apiDetailUrl,
    this.coverDate,
    this.dateAdded,
    this.dateLastUpdated,
    this.description,
    this.hasStaffReview,
    this.id,
    this.image,
    this.issueNumber,
    this.name,
    this.siteDetailUrl,
    this.storeDate,
    this.volume,
    this.characterCredits,
    this.locationCredits,
    this.teamCredits,
  });

  /// {@macro comic_vine_issue}
  /// A parser for the Issue model.
  /// Accepts a JSON Map and returns a [ComicVineIssue] object.
  factory ComicVineIssue.fromMap(Map map) {
    return ComicVineIssue(
      apiDetailUrl: map['api_detail_url'] as String?,
      coverDate: DateTime.tryParse(map['cover_date'] as String? ?? ''),
      dateAdded: DateTime.tryParse(map['date_added'] as String? ?? ''),
      dateLastUpdated:
          DateTime.tryParse(map['date_last_updated'] as String? ?? ''),
      description: map['description'] as String?,
      hasStaffReview: map['has_staff_review'] as bool?,
      id: map['id'] as int?,
      image: (map['image'] != null)
          ? ComicVineImage.fromMap(map['image'] as Map)
          : null,
      issueNumber: map['issue_number'] as String?,
      name: map['name'] as String?,
      siteDetailUrl: map['site_detail_url'] as String?,
      storeDate: DateTime.tryParse(map['store_date'] as String? ?? ''),
      volume: map['volume'] != null
          ? ComicVineVolume.fromMap(map['volume'] as Map)
          : null,
      locationCredits: (map['location_credits'] != null)
          ? (map['location_credits'] as List)
              .cast<Map>()
              .map(ComicVineVolume.fromMap)
              .toList()
          : null,
      characterCredits: (map['character_credits'] != null)
          ? (map['character_credits'] as List)
              .cast<Map>()
              .map(ComicVineVolume.fromMap)
              .toList()
          : null,
      teamCredits: (map['team_credits'] != null)
          ? (map['team_credits'] as List)
              .cast<Map>()
              .map(ComicVineVolume.fromMap)
              .toList()
          : null,
    );
  }

  /// URL pointing to the issue detail resource.
  final String? apiDetailUrl;

  /// The publish date printed on the cover of an issue.
  final DateTime? coverDate;

  /// Date the issue was added to Comic Vine.
  final DateTime? dateAdded;

  /// Date the issue was last updated on Comic Vine.
  final DateTime? dateLastUpdated;

  /// Description of the issue.
  final String? description;

  /// Whether or not the issue has a staff review.
  final bool? hasStaffReview;

  /// Unique ID of the issue.
  final int? id;

  /// Main image of the issue.
  final ComicVineImage? image;

  /// The number assigned to the issue within the volume set.
  final String? issueNumber;

  /// Name of the issue.
  final String? name;

  /// URL pointing to the issue on Giant Bomb.
  final String? siteDetailUrl;

  /// The date the issue was first sold in stores.
  final DateTime? storeDate;

  /// The volume this issue is a part of.
  final ComicVineVolume? volume;

  /// A list of characters that appear in this issue.
  final List<ComicVineVolume>? characterCredits;

  /// List of locations that appeared in this issue.
  final List<ComicVineVolume>? locationCredits;

  /// List of teams that appear in this issue.
  final List<ComicVineVolume>? teamCredits;

  @override
  String toString() {
    return '''
    ComicVineIssue(
      apiDetailUrl: $apiDetailUrl,
      coverDate: $coverDate,
      dateAdded: $dateAdded,
      dateLastUpdated: $dateLastUpdated,
      description: $description,
      hasStaffReview: $hasStaffReview,
      id: $id,
      image: $image,
      issueNumber: $issueNumber,
      name: $name,
      siteDetailUrl: $siteDetailUrl,
      storeDate: $storeDate,
      volume: $volume,
      characterCredits: $characterCredits,
      locationCredits: $locationCredits,
      teamCredits: $teamCredits
    )
    ''';
  }

  @override
  List<Object?> get props {
    return [
      apiDetailUrl,
      coverDate,
      dateAdded,
      dateLastUpdated,
      description,
      hasStaffReview,
      id,
      image,
      issueNumber,
      name,
      siteDetailUrl,
      storeDate,
      volume,
      characterCredits,
      locationCredits,
      teamCredits,
    ];
  }
}
