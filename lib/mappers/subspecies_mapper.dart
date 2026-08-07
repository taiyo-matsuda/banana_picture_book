import 'package:banana_picture_book/models/subspecies.dart';

class SubspeciesMapper {
  static Subspecies fromMap(Map<String, dynamic> map) {
    return Subspecies(id: map['id'] as int, name: map['name'] as String);
  }
}
