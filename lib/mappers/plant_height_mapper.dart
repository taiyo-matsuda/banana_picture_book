import 'package:banana_picture_book/models/plant_height.dart';

class PlantHeightMapper {
  static PlantHeight fromMap(Map<String, dynamic> data) {
    return PlantHeight(
      varietyId: data['variety_id'] as int,
      min: (data['pseudostem_height_min'] as num?)?.toDouble(),
      max: (data['pseudostem_height_max'] as num?)?.toDouble(),
    );
  }
}
