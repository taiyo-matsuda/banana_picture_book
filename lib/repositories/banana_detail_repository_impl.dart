import 'package:supabase_flutter/supabase_flutter.dart';

import '../mappers/banana_detail_mapper.dart';
import '../models/banana_detail.dart';
import 'banana_detail_repository.dart';

class BananaDetailRepositoryImpl implements BananaDetailRepository {
  final SupabaseClient supabase;

  BananaDetailRepositoryImpl(this.supabase);

  @override
  Future<BananaDetail> findByVarietyId(int varietyId) async {
    final response = await supabase
        .from('varieties')
        .select('''
          *,
          accessions(
            *,
            species(*),
            subspecies(*)
          ),
          origins(*),
          plant_traits(
            *,
            leaf_habits(*),
            pseudostem_aspects(*)
          ),
          male_flowers(*),
          petiole_midrib_leaves(*),
          inflorescence_male_buds(*),
          fruits(*),
          variety_complementary(*)
        ''')
        .eq('id', varietyId)
        .single();

    return BananaDetailMapper.fromMap(response);
  }
}
