import 'package:banana_picture_book/models/plant_height.dart';

import '../models/fruit_apex.dart';
import '../models/fruit_length.dart';
import '../models/fruit_transverse_section.dart';
import '../models/identification_candidate.dart';
import '../models/peduncle_hairiness.dart';
import '../models/peel_colour.dart';
import '../models/pulp_colour.dart';
import '../models/sap_colour.dart';

abstract class IdentificationRepository {
  Future<List<PlantHeight>> findPlantHeights();

  Future<List<PeelColour>> findPeelColours();

  Future<List<PulpColour>> findPulpColours();

  Future<List<FruitApex>> findFruitApexes();

  Future<List<FruitLength>> findFruitLengths();

  Future<List<FruitTransverseSection>> findFruitTransverseSections();

  Future<List<PeduncleHairiness>> findPeduncleHairiness();

  Future<List<SapColour>> findSapColours();

  Future<List<IdentificationCandidate>> findCandidates();
}
