import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'bottom_navigation.dart';

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
    return Scaffold(
      child: Column(
        children: [
          Expanded(child: navigationShell),
          BottomNavigation(
            currentIndex: navigationShell.currentIndex,
            onSelected: _onDestinationSelected,
          ),
        ],
      ),
    );
  }
}
