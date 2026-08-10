import 'package:banana_picture_book/models/plant_height.dart';

import '../models/peel_colour.dart';

abstract class IdentificationRepository {
  Future<List<PlantHeight>> findPlantHeights();
  Future<List<PeelColour>> findPeelColours();
}
