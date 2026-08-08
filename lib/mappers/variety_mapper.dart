import 'package:banana_picture_book/models/variety.dart';

class VarietyMapper {
  static Variety fromMap(Map<String, dynamic> map) {
    return Variety(
      id: map['id'] as int,
      musalogueName: map['musalogue_name'] as String,
      canonicalName: map['canonical_name'] as String,
      thumbnailImageUrl: map['thumbnail_image_url'] as String?,
    );
  }
}
