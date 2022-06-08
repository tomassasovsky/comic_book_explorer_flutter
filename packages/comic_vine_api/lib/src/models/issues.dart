/// {@template comic_vine_issue}
/// An Issue model for the Comic Vine API.
/// {@endtemplate}
class ComicVineIssue {
  /// {@macro comic_vine_issue}
  ComicVineIssue({
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
          ? IssueImage.fromMap(map['image'] as Map)
          : null,
      issueNumber: map['issue_number'] as String?,
      name: map['name'] as String?,
      siteDetailUrl: map['site_detail_url'] as String?,
      storeDate: DateTime.tryParse(map['store_date'] as String? ?? ''),
      volume: map['volume'] != null
          ? IssueVolume.fromMap(map['volume'] as Map)
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
  final IssueImage? image;

  /// The number assigned to the issue within the volume set.
  final String? issueNumber;

  /// Name of the issue.
  final String? name;

  /// URL pointing to the issue on Giant Bomb.
  final String? siteDetailUrl;

  /// The date the issue was first sold in stores.
  final DateTime? storeDate;

  /// The volume this issue is a part of.
  final IssueVolume? volume;

  /// {@macro comic_vine_generic_response}
  /// Convert this object to a JSON map.
  Map<String, dynamic> toMap() => <String, dynamic>{
        if (apiDetailUrl != null) 'api_detail_url': apiDetailUrl,
        if (coverDate != null) 'cover_date': coverDate?.toIso8601String(),
        if (dateAdded != null) 'date_added': dateAdded?.toIso8601String(),
        if (dateLastUpdated != null)
          'date_last_updated': dateLastUpdated?.toIso8601String(),
        if (description != null) 'description': description,
        if (hasStaffReview != null) 'has_staff_review': hasStaffReview,
        if (id != null) 'id': id,
        if (image != null) 'image': image?.toMap(),
        if (issueNumber != null) 'issue_number': issueNumber,
        if (name != null) 'name': name,
        if (siteDetailUrl != null) 'site_detail_url': siteDetailUrl,
        if (storeDate != null) 'store_date': storeDate?.toIso8601String(),
        if (volume != null) 'volume': volume?.toMap(),
      };
}

/// {@template comic_vine_image}
/// An Image model, found in the [ComicVineIssue] model.
/// {@endtemplate}
class IssueImage {
  /// {@macro comic_vine_image}
  IssueImage({
    this.iconUrl,
    this.mediumUrl,
    this.screenUrl,
    this.screenLargeUrl,
    this.smallUrl,
    this.superUrl,
    this.thumbUrl,
    this.tinyUrl,
    this.originalUrl,
    this.imageTags,
  });

  /// {@macro comic_vine_image}
  /// A parser for the Image model.
  /// Accepts a JSON Map and returns an [IssueImage] object.
  factory IssueImage.fromMap(Map map) => IssueImage(
        iconUrl: map['icon_url'] as String?,
        mediumUrl: map['medium_url'] as String?,
        screenUrl: map['screen_url'] as String?,
        screenLargeUrl: map['screen_large_url'] as String?,
        smallUrl: map['small_url'] as String?,
        superUrl: map['super_url'] as String?,
        thumbUrl: map['thumb_url'] as String?,
        tinyUrl: map['tiny_url'] as String?,
        originalUrl: map['original_url'] as String?,
        imageTags: map['image_tags'] as String?,
      );

  /// The URL of the icon image.
  final String? iconUrl;

  /// The URL of the medium-sized image.
  final String? mediumUrl;

  /// The URL of the screen-sized image.
  final String? screenUrl;

  /// The URL of the large-screen-sized image.
  final String? screenLargeUrl;

  /// The URL of the small-sized image.
  final String? smallUrl;

  /// The URL of the super-sized image.
  final String? superUrl;

  /// The URL of the thumb-sized image.
  final String? thumbUrl;

  /// The URL of the tiny-sized image.
  final String? tinyUrl;

  /// The URL of the original image.
  final String? originalUrl;

  /// The tags of the image.
  final String? imageTags;

  /// {@macro comic_vine_image}
  /// Convert this object to a JSON map.
  Map<String, dynamic> toMap() => <String, String?>{
        if (iconUrl != null) 'icon_url': iconUrl,
        if (mediumUrl != null) 'medium_url': mediumUrl,
        if (screenUrl != null) 'screen_url': screenUrl,
        if (screenLargeUrl != null) 'screen_large_url': screenLargeUrl,
        if (smallUrl != null) 'small_url': smallUrl,
        if (superUrl != null) 'super_url': superUrl,
        if (thumbUrl != null) 'thumb_url': thumbUrl,
        if (tinyUrl != null) 'tiny_url': tinyUrl,
        if (originalUrl != null) 'original_url': originalUrl,
        if (imageTags != null) 'image_tags': imageTags,
      };
}

/// {@template comic_vine_volume}
/// A Volume model, found in the [IssueVolume] model.
/// {@endtemplate}
class IssueVolume {
  /// {@macro comic_vine_volume}
  IssueVolume({
    this.apiDetailUrl,
    this.id,
    this.name,
    this.siteDetailUrl,
  });

  /// {@macro comic_vine_volume}
  /// A parser for the Volume model.
  /// Accepts a JSON Map and returns an [IssueVolume] object.
  factory IssueVolume.fromMap(Map map) => IssueVolume(
        apiDetailUrl: map['api_detail_url'] as String?,
        id: map['id'] as int?,
        name: map['name'] as String?,
        siteDetailUrl: map['site_detail_url'] as String?,
      );

  /// The URL of the API detail of the volume.
  final String? apiDetailUrl;

  /// Unique ID of the volume.
  final int? id;

  /// Name of the volume.
  final String? name;

  /// URL pointing to the volume on Giant Bomb.
  final String? siteDetailUrl;

  /// {@macro comic_vine_volume}
  /// Convert this object to a JSON map.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'api_detail_url': apiDetailUrl,
        'id': id,
        'name': name,
        'site_detail_url': siteDetailUrl,
      };
}
