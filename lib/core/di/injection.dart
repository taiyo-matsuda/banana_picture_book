import 'package:get_it/get_it.dart';

import '../../repositories/brief_banana_repository.dart';
import '../../repositories/brief_banana_repository_imple.dart';
import '../../repositories/datasource/supabase/supabase_client.dart';
import '../../repositories/identification_repository.dart';
import '../../repositories/identification_repository_impl.dart';
import '../../services/identification_scorer.dart';
import '../../services/identification_session.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<BriefBananaRepository>(
    () => BriefBananaRepositoryImpl(SupabaseConfig.client),
  );

  getIt.registerLazySingleton<IdentificationRepository>(
    () => IdentificationRepositoryImpl(SupabaseConfig.client),
  );

  getIt.registerSingleton<IdentificationSession>(IdentificationSession());

  getIt.registerLazySingleton<IdentificationScorer>(
    () => IdentificationScorer(),
  );
}
