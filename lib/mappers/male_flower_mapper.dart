import '../models/male_flower.dart';

class MaleFlowerMapper {
  static MaleFlower fromMap(Map<String, dynamic> map) {
    return MaleFlower(
      id: map['id'] as int,
      varietyId: map['variety_id'] as int,
      compoundTepalBasicColour: map['compound_tepal_basic_colour'] as String?,
      compoundTepalPigmentation: map['compound_tepal_pigmentation'] as String?,
      compoundTepalLobeColour: map['compound_tepal_lobe_colour'] as String?,
      freeTepalAppearance: map['free_tepal_appearance'] as String?,
      styleShape: map['style_shape'] as String?,
      stigmaColour: map['stigma_colour'] as String?,
      ovaryBasicColour: map['ovary_basic_colour'] as String?,
      ovaryPigmentation: map['ovary_pigmentation'] as String?,
    );
  }
}
