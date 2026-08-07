import 'package:banana_picture_book/models/origin.dart';

class OriginMapper {
  static Origin fromMap(Map<String, dynamic> map) {
    return Origin(
      id: map['id'] as int,
      varietyId: map['variety_id'] as int,
      origin: map['origin'] as String?,
      province: map['province'] as String?,
      exactLocation: map['exact_location'] as String?,
      collectingSource: map['collecting_source'] as String?,
      localVernacularName: map['local_vernacular_name'] as String?,
      accessionCode: map['accession_code'] as String?,
      useForDessert: map['use_for_dessert'] as bool,
      useForCooking: map['use_for_cooking'] as bool,
    );
  }
}
