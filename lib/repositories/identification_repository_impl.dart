import 'package:banana_picture_book/mappers/plant_height_mapper.dart';
import 'package:banana_picture_book/models/plant_height.dart';
import 'package:banana_picture_book/repositories/identification_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/fruit_apex.dart';
import '../models/fruit_length.dart';
import '../models/fruit_transverse_section.dart';
import '../models/identification_candidate.dart';
import '../models/peduncle_hairiness.dart';
import '../models/peel_colour.dart';
import '../models/pulp_colour.dart';
import '../models/sap_colour.dart';

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

  @override
  Future<List<PulpColour>> findPulpColours() async {
    final response = await supabase
        .from('fruits')
        .select('pulp_colour_at_maturity')
        .not('pulp_colour_at_maturity', 'is', null);

    return response.map<PulpColour>((data) {
      return PulpColour(value: data['pulp_colour_at_maturity'] as String);
    }).toList();
  }

  @override
  Future<List<FruitApex>> findFruitApexes() async {
    final response = await supabase
        .from('fruits')
        .select('fruit_apex')
        .not('fruit_apex', 'is', null);

    return response.map<FruitApex>((data) {
      return FruitApex(value: data['fruit_apex'] as String);
    }).toList();
  }

  @override
  Future<List<FruitLength>> findFruitLengths() async {
    final response = await supabase
        .from('fruits')
        .select('fruit_length_min, fruit_length_max');

    return response
        .map<FruitLength>((data) => FruitLength.fromMap(data))
        .toList();
  }

  @override
  Future<List<FruitTransverseSection>> findFruitTransverseSections() async {
    final response = await supabase
        .from('fruits')
        .select('fruit_transverse_section')
        .not('fruit_transverse_section', 'is', null);

    return response
        .map<FruitTransverseSection>(
          (data) => FruitTransverseSection.fromMap(data),
        )
        .toList();
  }

  @override
  Future<List<PeduncleHairiness>> findPeduncleHairiness() async {
    final response = await supabase
        .from('inflorescence_male_buds')
        .select('peduncle_hairiness')
        .not('peduncle_hairiness', 'is', null);

    return response
        .map<PeduncleHairiness>((data) => PeduncleHairiness.fromMap(data))
        .toList();
  }

  @override
  Future<List<SapColour>> findSapColours() async {
    final response = await supabase
        .from('plant_traits')
        .select('sap_colour')
        .not('sap_colour', 'is', null);

    return response.map<SapColour>((data) => SapColour.fromMap(data)).toList();
  }

  @override
  Future<List<IdentificationCandidate>> findCandidates() async {
    final response = await supabase.from('varieties').select('''
        id,
        canonical_name,
        musalogue_name,
        plant_traits (
          pseudostem_height_min,
          pseudostem_height_max,
          sap_colour
        ),
        fruits (
          mature_peel_colour,
          pulp_colour_at_maturity,
          fruit_apex,
          fruit_length_min,
          fruit_length_max,
          fruit_transverse_section
        ),
        inflorescence_male_buds (
          peduncle_hairiness
        )
      ''');

    return response.map<IdentificationCandidate>((data) {
      final plantTraits = _firstMap(data['plant_traits']);

      final fruit = _firstMap(data['fruits']);

      final inflorescenceMaleBud = _firstMap(data['inflorescence_male_buds']);

      return IdentificationCandidate(
        varietyId: data['id'] as int,
        canonicalName: data['canonical_name'] as String,
        musalogueName: data['musalogue_name'] as String?,
        heightMin: _toDouble(plantTraits?['pseudostem_height_min']),
        heightMax: _toDouble(plantTraits?['pseudostem_height_max']),
        peelColour: fruit?['mature_peel_colour'] as String?,
        pulpColour: fruit?['pulp_colour_at_maturity'] as String?,
        fruitApex: fruit?['fruit_apex'] as String?,
        fruitLengthMin: _toDouble(fruit?['fruit_length_min']),
        fruitLengthMax: _toDouble(fruit?['fruit_length_max']),
        fruitTransverseSection: fruit?['fruit_transverse_section'] as String?,
        peduncleHairiness:
            inflorescenceMaleBud?['peduncle_hairiness'] as String?,
        sapColour: plantTraits?['sap_colour'] as String?,
      );
    }).toList();
  }

  Map<String, dynamic>? _firstMap(dynamic value) {
    if (value is List && value.isNotEmpty) {
      final first = value.first;

      if (first is Map) {
        return Map<String, dynamic>.from(first);
      }
    }

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return null;
  }

  double? _toDouble(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString());
  }
}
