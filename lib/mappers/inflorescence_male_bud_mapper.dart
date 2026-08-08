import '../models/inflorescence_male_bud.dart';

class InflorescenceMaleBudMapper {
  static InflorescenceMaleBud fromMap(Map<String, dynamic> map) {
    return InflorescenceMaleBud(
      id: map['id'] as int,
      varietyId: map['variety_id'] as int,
      peduncleLengthMin: (map['peduncle_length_min'] as num?)?.toDouble(),
      peduncleLengthMax: (map['peduncle_length_max'] as num?)?.toDouble(),
      peduncleHairiness: map['peduncle_hairiness'] as String?,
      bunchPosition: map['bunch_position'] as String?,
      rachisType: map['rachis_type'] as String?,
      rachisPosition: map['rachis_position'] as String?,
      rachisAppearance: map['rachis_appearance'] as String?,
      maleBudType: map['male_bud_type'] as String?,
      maleBudShape: map['male_bud_shape'] as String?,
      bractApexShape: map['bract_apex_shape'] as String?,
      bractImbrication: map['bract_imbrication'] as String?,
      bractExternalColour: map['bract_external_colour'] as String?,
      bractInternalColour: map['bract_internal_colour'] as String?,
      bractScarsOnRachis: map['bract_scars_on_rachis'] as String?,
      bractBaseColourFading: map['bract_base_colour_fading'] as String?,
      bractBehaviourBeforeFalling:
          map['bract_behaviour_before_falling'] as String?,
      bractWax: map['bract_wax'] as String?,
    );
  }
}
