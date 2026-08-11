import 'package:banana_picture_book/models/plant_height.dart';

import '../models/fruit_apex.dart';
import '../models/fruit_length.dart';
import '../models/peel_colour.dart';
import '../models/pulp_colour.dart';

abstract class IdentificationRepository {
  Future<List<PlantHeight>> findPlantHeights();

  Future<List<PeelColour>> findPeelColours();

  Future<List<PulpColour>> findPulpColours();

  Future<List<FruitApex>> findFruitApexes();

  Future<List<FruitLength>> findFruitLengths();
}
