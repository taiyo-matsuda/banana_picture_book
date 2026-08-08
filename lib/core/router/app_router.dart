import 'package:go_router/go_router.dart';

import '../../repositories/brief_banana_repository.dart';
import '../../screens/banana_detail_screen.dart';
import '../../screens/banana_list_screen.dart';

GoRouter createAppRouter({required BriefBananaRepository repository}) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return BananaListScreen(repository: repository);
        },
      ),
      GoRoute(
        path: '/bananas/:varietyId',
        builder: (context, state) {
          final varietyId = int.parse(state.pathParameters['varietyId']!);
          final canonicalName = state.extra as String?;

          return BananaDetailScreen(
            varietyId: varietyId,
            canonicalName: canonicalName,
          );
        },
      ),
    ],
  );
}
