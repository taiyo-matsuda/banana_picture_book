import 'package:shadcn_flutter/shadcn_flutter.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({super.key, required this.title, required this.children});

  final String title;
  final List children;

  @override
  Widget build(BuildContext context) {
    final visibleChildren = children
        .where((child) => child is! SizedBox)
        .toList();

    if (visibleChildren.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Divider(),
          ...visibleChildren,
        ],
      ),
    );
  }
}
