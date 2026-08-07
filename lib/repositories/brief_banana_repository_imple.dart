import 'package:banana_picture_book/mappers/brief_banana_mapper.dart';
import 'package:banana_picture_book/models/brief_banana.dart';
import 'package:banana_picture_book/repositories/brief_banana_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BriefBananaRepositoryImpl implements BriefBananaRepository {
  final SupabaseClient supabase;

  BriefBananaRepositoryImpl(this.supabase);

  @override
  Future<List<BriefBanana>> findAll() async {
    final response = await supabase.from('varieties').select('''
          *,
          accessions(
            *,
            species(*),
            subspecies(*)
          ),
          origins(*)
        ''');

    return response
        .map<BriefBanana>((data) => BriefBananaMapper.fromMap(data))
        .toList();
  }
}
