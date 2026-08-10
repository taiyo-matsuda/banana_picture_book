import 'package:go_router/go_router.dart';

import '../../repositories/brief_banana_repository.dart';
import '../../screens/banana_detail_screen.dart';
import '../../screens/banana_list_screen.dart';
import '../../screens/identify_height_screen.dart';
import '../../screens/identify_peel_screen.dart';
import '../../screens/identify_screen.dart';
import '../di/injection.dart';
import 'main_shell.dart';

GoRouter createAppRouter() {
  return GoRouter(
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // 図鑑
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return BananaListScreen(
                    repository: getIt<BriefBananaRepository>(),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'bananas/:varietyId',
                    builder: (context, state) {
                      final varietyId = int.parse(
                        state.pathParameters['varietyId']!,
                      );

                      final canonicalName = state.extra as String?;

                      return BananaDetailScreen(
                        varietyId: varietyId,
                        canonicalName: canonicalName,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // 特定
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/identify',
                builder: (context, state) {
                  return const IdentifyScreen();
                },
                routes: [
                  GoRoute(
                    path: 'height',
                    builder: (context, state) {
                      return IdentifyHeightScreen();
                    },
                  ),
                  GoRoute(
                    path: 'peel-colour',
                    builder: (context, state) {
                      return IdentifyPeelScreen();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
