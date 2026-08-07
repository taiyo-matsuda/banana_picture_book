import 'package:banana_picture_book/mappers/species_mapper.dart';
import 'package:banana_picture_book/mappers/subspecies_mapper.dart';
import 'package:banana_picture_book/models/accession.dart';

class AccessionMapper {
  static Accession fromMap(Map<String, dynamic> map) {
    return Accession(
      id: map['id'] as int,
      varietyId: map['variety_id'] as int,
      mgisAccessionNumber: map['mgis_accession_number'] as String,
      genus: map['genus'] as String,
      species: SpeciesMapper.fromMap(map['species']),
      subspecies: SubspeciesMapper.fromMap(map['subspecies']),
    );
  }
}
