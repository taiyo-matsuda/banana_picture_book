import 'package:banana_picture_book/models/species.dart';

class SpeciesMapper {
  static Species fromMap(Map<String, dynamic> map) {
    return Species(id: map['id'] as int, name: map['name'] as String);
  }
}
