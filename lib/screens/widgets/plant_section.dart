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
      title: '植物体・偽茎',
      children: [
        DetailRow(label: '葉の性状', value: data.leafHabit),
        DetailRow(
          label: '偽茎の高さ',
          value: range(
            data.pseudostemHeightMin,
            data.pseudostemHeightMax,
            suffix: ' m',
          ),
        ),
        DetailRow(label: '偽茎の色', value: data.pseudostemColour),
        DetailRow(label: '偽茎の外観', value: data.pseudostemAppearance),
        DetailRow(
          label: '偽茎内部の着色',
          value: data.underlyingPseudostemPigmentation,
        ),
        DetailRow(label: '偽茎の形状', value: data.pseudostemAspect),
        DetailRow(label: '樹液の色', value: data.sapColour),
        DetailRow(
          label: '吸芽数',
          value: intRange(data.suckersMin, data.suckersMax),
        ),
        DetailRow(label: '吸芽の発達', value: data.suckerDevelopment),
        DetailRow(label: '吸芽の位置', value: data.suckerPosition),
        DetailRow(label: '葉柄基部の斑点', value: data.petioleBaseBlotches),
        DetailRow(label: '斑点の色', value: data.blotchesColour),
      ],
    );
  }
}
