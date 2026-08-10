import 'package:banana_picture_book/models/plant_height.dart';

abstract class IdentificationRepository {
  Future<List<PlantHeight>> findPlantHeights();
}
