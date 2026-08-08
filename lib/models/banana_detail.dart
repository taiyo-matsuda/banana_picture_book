import 'accession.dart';
import 'fruit.dart';
import 'inflorescence_male_bud.dart';
import 'male_flower.dart';
import 'origin.dart';
import 'petiole_midrib_leaf.dart';
import 'plant_trait.dart';
import 'variety.dart';
import 'variety_complementary.dart';

class BananaDetail {
  final Variety variety;
  final Accession accession;
  final Origin origin;

  final PlantTrait? plantTrait;
  final MaleFlower? maleFlower;
  final PetioleMidribLeaf? petioleMidribLeaf;
  final InflorescenceMaleBud? inflorescenceMaleBud;
  final Fruit? fruit;

  final List<VarietyComplementary> complementary;

  const BananaDetail({
    required this.variety,
    required this.accession,
    required this.origin,
    this.plantTrait,
    this.maleFlower,
    this.petioleMidribLeaf,
    this.inflorescenceMaleBud,
    this.fruit,
    this.complementary = const [],
  });
}
