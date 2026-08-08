import '../models/plant_trait.dart';

class PlantTraitMapper {
  static PlantTrait fromMap(Map<String, dynamic> map) {
    final leafHabit = map['leaf_habits'];
    final pseudostemAspect = map['pseudostem_aspects'];

    return PlantTrait(
      id: map['id'] as int,
      varietyId: map['variety_id'] as int,
      leafHabit: leafHabit is Map<String, dynamic>
          ? leafHabit['name'] as String?
          : null,
      pseudostemHeightMin: (map['pseudostem_height_min'] as num?)?.toDouble(),
      pseudostemHeightMax: (map['pseudostem_height_max'] as num?)?.toDouble(),
      pseudostemColour: map['pseudostem_colour'] as String?,
      pseudostemAppearance: map['pseudostem_appearance'] as String?,
      underlyingPseudostemPigmentation:
          map['underlying_pseudostem_pigmentation'] as String?,
      sapColour: map['sap_colour'] as String?,
      suckersMin: map['suckers_min'] as int?,
      suckersMax: map['suckers_max'] as int?,
      suckerDevelopment: map['sucker_development'] as String?,
      suckerPosition: map['sucker_position'] as String?,
      petioleBaseBlotches: map['petiole_base_blotches'] as String?,
      blotchesColour: map['blotches_colour'] as String?,
      pseudostemAspect: pseudostemAspect is Map<String, dynamic>
          ? pseudostemAspect['name'] as String?
          : null,
    );
  }
}
