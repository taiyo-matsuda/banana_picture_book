import '../models/banana_detail.dart';

abstract class BananaDetailRepository {
  Future<BananaDetail> findByVarietyId(int varietyId);
}
