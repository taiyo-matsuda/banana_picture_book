import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../repositories/brief_banana_repository.dart';
import '../../screens/banana_detail_screen.dart';
import '../../screens/banana_list_screen.dart';
import '../../screens/identify_screen.dart';

GoRouter createAppRouter({required BriefBananaRepository repository}) {
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
                  return BananaListScreen(repository: repository);
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
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      child: Column(
        children: [
          Expanded(child: navigationShell),
          _BottomNavigation(
            currentIndex: currentIndex,
            onSelected: _onDestinationSelected,
          ),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({
    required this.currentIndex,
    required this.onSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: const Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          Expanded(
            child: _NavigationItem(
              icon: Icons.menu_book_outlined,
              selectedIcon: Icons.menu_book,
              label: '図鑑',
              selected: currentIndex == 0,
              onTap: () => onSelected(0),
            ),
          ),
          Expanded(
            child: _NavigationItem(
              icon: Icons.search_outlined,
              selectedIcon: Icons.search,
              label: '特定',
              selected: currentIndex == 1,
              onTap: () => onSelected(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xFF18181B);
    const unselectedColor = Color(0xFF71717A);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFF4F4F5)
                    : const Color(0x00000000),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                selected ? selectedIcon : icon,
                size: 22,
                color: selected ? selectedColor : unselectedColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
