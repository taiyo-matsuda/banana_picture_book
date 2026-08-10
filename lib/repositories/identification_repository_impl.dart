import 'package:banana_picture_book/mappers/plant_height_mapper.dart';
import 'package:banana_picture_book/models/plant_height.dart';
import 'package:banana_picture_book/repositories/identification_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/peel_colour.dart';

class IdentificationRepositoryImpl implements IdentificationRepository {
  IdentificationRepositoryImpl(this.supabase);

  final SupabaseClient supabase;

  @override
  Future<List<PlantHeight>> findPlantHeights() async {
    final response = await supabase
        .from('plant_traits')
        .select('variety_id, pseudostem_height_min, pseudostem_height_max');

    return response
        .map<PlantHeight>((data) => PlantHeightMapper.fromMap(data))
        .toList();
  }

  @override
  Future<List<PeelColour>> findPeelColours() async {
    final response = await supabase
        .from('fruits')
        .select('mature_peel_colour')
        .not('mature_peel_colour', 'is', null);

    return response.map<PeelColour>((data) {
      return PeelColour(value: data['mature_peel_colour'] as String);
    }).toList();
  }
}
