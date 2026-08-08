import '../models/variety_complementary.dart';

class VarietyComplementaryMapper {
  static VarietyComplementary fromMap(Map<String, dynamic> map) {
    return VarietyComplementary(
      id: map['id'] as int,
      varietyId: map['variety_id'] as int,
      complementary: map['complementary'] as String,
    );
  }
}
