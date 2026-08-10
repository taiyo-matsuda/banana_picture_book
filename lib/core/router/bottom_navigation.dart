import 'package:shadcn_flutter/shadcn_flutter.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
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
