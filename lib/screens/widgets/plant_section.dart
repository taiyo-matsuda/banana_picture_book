import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../core/utils/formatters.dart';
import '../../models/plant_trait.dart';
import 'detail_row.dart';
import 'detail_section.dart';

class PlantSection extends StatelessWidget {
  const PlantSection({super.key, required this.plantTrait});

  final PlantTrait? plantTrait;

  @override
  Widget build(BuildContext context) {
    if (plantTrait == null) {
      return const SizedBox.shrink();
    }

    final data = plantTrait!;

    return DetailSection(
      title: 'Plant / Pseudostem',
      children: [
        DetailRow(label: 'Leaf habit', value: data.leafHabit),
        DetailRow(
          label: 'Pseudostem height',
          value: range(
            data.pseudostemHeightMin,
            data.pseudostemHeightMax,
            suffix: ' m',
          ),
        ),
        DetailRow(label: 'Pseudostem colour', value: data.pseudostemColour),
        DetailRow(
          label: 'Pseudostem appearance',
          value: data.pseudostemAppearance,
        ),
        DetailRow(
          label: 'Underlying pseudostem pigmentation',
          value: data.underlyingPseudostemPigmentation,
        ),
        DetailRow(label: 'Pseudostem aspect', value: data.pseudostemAspect),
        DetailRow(label: 'Sap colour', value: data.sapColour),
        DetailRow(
          label: 'Suckers',
          value: intRange(data.suckersMin, data.suckersMax),
        ),
        DetailRow(label: 'Sucker development', value: data.suckerDevelopment),
        DetailRow(label: 'Sucker position', value: data.suckerPosition),
        DetailRow(
          label: 'Petiole base blotches',
          value: data.petioleBaseBlotches,
        ),
        DetailRow(label: 'Blotches colour', value: data.blotchesColour),
      ],
    );
  }
}
