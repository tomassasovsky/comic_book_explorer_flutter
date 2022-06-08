import 'package:equatable/equatable.dart';

/// {@template comic_vine_image_resource}
/// Where the image is grabbed from.
/// {@endtemplate}
enum ComicVineImageResource {
  /// Grab the image from the /character/ endpoint.
  character,

  /// Grab the image from the /location/ endpoint.
  location,

  /// Grab the image from the /team/ endpoint.
  team,
}

/// {@template comic_vine_image_response}
/// The response from the ComicVine API when fetching an image of
/// a character, location, or team.
/// {@endtemplate}
class ComicVineImageResponse extends Equatable {
  /// {@macro comic_vine_image_response}
  const ComicVineImageResponse({
    this.image,
    this.name,
  });

  /// {@macro comic_vine_image_response}
  /// A parser for the Image model.
  /// Accepts a JSON Map and returns an [ComicVineImage] object.
  factory ComicVineImageResponse.fromMap(Map map) {
    map = map.cast<String, dynamic>();
    return ComicVineImageResponse(
      image: (map['image'] != null)
          ? ComicVineImage.fromMap(map['image'] as Map)
          : null,
      name: map['name'] as String?,
    );
  }

  /// The image data.
  final ComicVineImage? image;

  /// The name of the character/location/team.
  final String? name;

  @override
  List<Object?> get props => [image, name];
}

/// {@template comic_vine_image}
/// An Image Data model.
/// {@endtemplate}
class ComicVineImage extends Equatable {
  /// {@macro comic_vine_image}
  const ComicVineImage({
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
  /// Accepts a JSON Map and returns an [ComicVineImage] object.
  factory ComicVineImage.fromMap(Map map) => ComicVineImage(
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

  @override
  String toString() {
    return '''
    IssueImage(
      iconUrl: $iconUrl,
      mediumUrl: $mediumUrl,
      screenUrl: $screenUrl,
      screenLargeUrl: $screenLargeUrl,
      smallUrl: $smallUrl,
      superUrl: $superUrl,
      thumbUrl: $thumbUrl,
      tinyUrl: $tinyUrl,
      originalUrl: $originalUrl,
      imageTags: $imageTags
    )
    ''';
  }

  @override
  List<Object?> get props {
    return [
      iconUrl,
      mediumUrl,
      screenUrl,
      screenLargeUrl,
      smallUrl,
      superUrl,
      thumbUrl,
      tinyUrl,
      originalUrl,
      imageTags,
    ];
  }
}
