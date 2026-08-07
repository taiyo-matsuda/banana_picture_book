import 'package:banana_picture_book/models/brief_banana.dart';

abstract class BriefBananaRepository {
  Future<List<BriefBanana>> getBriefBananas();
}
