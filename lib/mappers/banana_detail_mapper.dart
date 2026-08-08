import '../models/banana_detail.dart';

import 'accession_mapper.dart';
import 'fruit_mapper.dart';
import 'inflorescence_male_bud_mapper.dart';
import 'male_flower_mapper.dart';
import 'origin_mapper.dart';
import 'petiole_midrib_leaf_mapper.dart';
import 'plant_trait_mapper.dart';
import 'variety_complementary_mapper.dart';
import 'variety_mapper.dart';

class BananaDetailMapper {
  static BananaDetail fromMap(Map<String, dynamic> map) {
    final accessionMap = map['accessions'];
    final originMap = map['origins'];
    final plantTraitMap = map['plant_traits'];
    final maleFlowerMap = map['male_flowers'];
    final petioleMap = map['petiole_midrib_leaves'];
    final inflorescenceMap = map['inflorescence_male_buds'];
    final fruitMap = map['fruits'];

    final complementaryList =
        (map['variety_complementary'] as List<dynamic>? ?? []);

    return BananaDetail(
      variety: VarietyMapper.fromMap(map),
      accession: AccessionMapper.fromMap(_singleRelation(accessionMap)),
      origin: OriginMapper.fromMap(_singleRelation(originMap)),
      plantTrait: plantTraitMap == null
          ? null
          : PlantTraitMapper.fromMap(_singleRelation(plantTraitMap)),
      maleFlower: maleFlowerMap == null
          ? null
          : MaleFlowerMapper.fromMap(_singleRelation(maleFlowerMap)),
      petioleMidribLeaf: petioleMap == null
          ? null
          : PetioleMidribLeafMapper.fromMap(_singleRelation(petioleMap)),
      inflorescenceMaleBud: inflorescenceMap == null
          ? null
          : InflorescenceMaleBudMapper.fromMap(
              _singleRelation(inflorescenceMap),
            ),
      fruit: fruitMap == null
          ? null
          : FruitMapper.fromMap(_singleRelation(fruitMap)),
      complementary: complementaryList
          .map(
            (item) => VarietyComplementaryMapper.fromMap(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> _singleRelation(dynamic value) {
    if (value is List && value.isNotEmpty) {
      return Map<String, dynamic>.from(value.first);
    }

    if (value is Map<String, dynamic>) {
      return value;
    }

    return {};
  }
}
