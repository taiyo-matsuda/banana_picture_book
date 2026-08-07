import 'package:banana_picture_book/mappers/accession_mapper.dart';
import 'package:banana_picture_book/mappers/origin_mapper.dart';
import 'package:banana_picture_book/mappers/variety_mapper.dart';
import 'package:banana_picture_book/models/brief_banana.dart';

class BriefBananaMapper {
  static BriefBanana fromMap(Map<String, dynamic> map) {
    return BriefBanana(
      variety: VarietyMapper.fromMap(map),
      accession: AccessionMapper.fromMap(map['accessions']),
      origin: OriginMapper.fromMap(map['origins']),
    );
  }
}
