import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../models/variety_complementary.dart';
import 'detail_section.dart';

class ComplementarySection extends StatelessWidget {
  const ComplementarySection({super.key, required this.items});

  final List<VarietyComplementary> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return DetailSection(
      title: 'Complementary',
      children: items
          .map<Widget>(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                item.complementary,
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ),
          )
          .toList(),
    );
  }
}
