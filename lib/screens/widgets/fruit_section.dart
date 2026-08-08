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
        DetailRow(label: '果実の着生位置', value: data.fruitPosition),
        DetailRow(
          label: '果実数',
          value: intRange(data.fruitsMin, data.fruitsMax),
        ),
        DetailRow(
          label: '果実長［cm］',
          value: range(data.fruitLengthMin, data.fruitLengthMax, suffix: ' cm'),
        ),
        DetailRow(label: '果実形', value: data.fruitShape),
        DetailRow(label: '果実の横断面', value: data.fruitTransverseSection),
        DetailRow(label: '果実先端', value: data.fruitApex),
        DetailRow(label: '果実先端に残る花器官', value: data.flowerRelictsAtApex),
        DetailRow(
          label: '果柄長［mm］',
          value: range(
            data.fruitPedicelLengthMin,
            data.fruitPedicelLengthMax,
            suffix: ' mm',
          ),
        ),
        DetailRow(label: '成熟果皮色', value: data.maturePeelColour),
        DetailRow(label: '果肉', value: data.pulpPresence.toString()),
        DetailRow(label: '成熟時の果肉色', value: data.pulpColourAtMaturity),
        DetailRow(
          label: '花粉源による種子形成',
          value: intRange(
            data.seedsWithPollenSourceMin,
            data.seedsWithPollenSourceMax,
          ),
        ),
        DetailRow(label: '種子形', value: data.seedShape),
      ],
    );
  }
}
