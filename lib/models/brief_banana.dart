import 'package:banana_picture_book/models/accession.dart';
import 'package:banana_picture_book/models/origin.dart';
import 'package:banana_picture_book/models/variety.dart';

class BriefBanana {
  final Variety variety;
  final Accession accession;
  final Origin origin;

  const BriefBanana({
    required this.variety,
    required this.accession,
    required this.origin,
  });
}
