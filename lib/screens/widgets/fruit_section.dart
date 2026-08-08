import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../core/utils/formatters.dart';
import '../../models/fruit.dart';
import 'detail_row.dart';
import 'detail_section.dart';

class FruitSection extends StatelessWidget {
  const FruitSection({super.key, required this.fruit});

  final Fruit? fruit;

  @override
  Widget build(BuildContext context) {
    if (fruit == null) {
      return const SizedBox.shrink();
    }

    final data = fruit!;

    return DetailSection(
      title: 'Fruit',
      children: [
        DetailRow(label: 'Fruit position', value: data.fruitPosition),
        DetailRow(
          label: 'Number of fruits',
          value: intRange(data.fruitsMin, data.fruitsMax),
        ),
        DetailRow(
          label: 'Fruit length',
          value: range(data.fruitLengthMin, data.fruitLengthMax, suffix: ' cm'),
        ),
        DetailRow(label: 'Fruit shape', value: data.fruitShape),
        DetailRow(
          label: 'Transverse section of fruit',
          value: data.fruitTransverseSection,
        ),
        DetailRow(label: 'Fruit apex', value: data.fruitApex),
        DetailRow(
          label: 'Flower relicts at apex',
          value: data.flowerRelictsAtApex,
        ),
        DetailRow(
          label: 'Fruit pedicel length',
          value: range(
            data.fruitPedicelLengthMin,
            data.fruitPedicelLengthMax,
            suffix: ' mm',
          ),
        ),
        DetailRow(label: 'Mature peel colour', value: data.maturePeelColour),
        DetailRow(label: 'Pulp', value: data.pulpPresence),
        DetailRow(
          label: 'Pulp colour at maturity',
          value: data.pulpColourAtMaturity,
        ),
        DetailRow(
          label: 'Seeds with pollen source',
          value: intRange(
            data.seedsWithPollenSourceMin,
            data.seedsWithPollenSourceMax,
          ),
        ),
        DetailRow(label: 'Seed shape', value: data.seedShape),
      ],
    );
  }
}
