import '../models/fruit.dart';

class FruitMapper {
  static Fruit fromMap(Map<String, dynamic> map) {
    return Fruit(
      id: map['id'] as int,
      varietyId: map['variety_id'] as int,
      fruitPosition: map['fruit_position'] as String?,
      fruitsMin: map['fruits_min'] as int?,
      fruitsMax: map['fruits_max'] as int?,
      fruitLengthMin: (map['fruit_length_min'] as num?)?.toDouble(),
      fruitLengthMax: (map['fruit_length_max'] as num?)?.toDouble(),
      fruitShape: map['fruit_shape'] as String?,
      fruitTransverseSection: map['fruit_transverse_section'] as String?,
      fruitApex: map['fruit_apex'] as String?,
      flowerRelictsAtApex: map['flower_relicts_at_apex'] as String?,
      fruitPedicelLengthMin: (map['fruit_pedicel_length_min'] as num?)
          ?.toDouble(),
      fruitPedicelLengthMax: (map['fruit_pedicel_length_max'] as num?)
          ?.toDouble(),
      maturePeelColour: map['mature_peel_colour'] as String?,
      pulpPresence: map['pulp_presence'] as String?,
      pulpColourAtMaturity: map['pulp_colour_at_maturity'] as String?,
      seedsWithPollenSourceMin: map['seeds_with_pollen_source_min'] as int?,
      seedsWithPollenSourceMax: map['seeds_with_pollen_source_max'] as int?,
      seedShape: map['seed_shape'] as String?,
    );
  }
}
