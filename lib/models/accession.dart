import 'package:banana_picture_book/models/species.dart';
import 'package:banana_picture_book/models/subspecies.dart';

class Accession {
  final int id;
  final int varietyId;
  final String mgisAccessionNumber;
  final String genus;
  final Species species;
  final Subspecies subspecies;

  const Accession({
    required this.id,
    required this.varietyId,
    required this.mgisAccessionNumber,
    required this.genus,
    required this.species,
    required this.subspecies,
  });
}
