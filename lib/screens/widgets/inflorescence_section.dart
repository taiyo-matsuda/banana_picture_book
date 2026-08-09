import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../core/utils/formatters.dart';
import '../../models/inflorescence_male_bud.dart';
import 'detail_row.dart';
import 'detail_section.dart';

class InflorescenceSection extends StatelessWidget {
  const InflorescenceSection({super.key, required this.data});

  final InflorescenceMaleBud? data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const SizedBox.shrink();
    }

    final value = data!;

    return DetailSection(
      title: '花序・雄花蕾',
      children: [
        DetailRow(
          label: '花茎の長さ',
          value: range(value.peduncleLengthMin, value.peduncleLengthMax),
        ),
        DetailRow(label: '花茎の毛', value: value.peduncleHairiness),
        DetailRow(label: '果房の位置', value: value.bunchPosition),
        DetailRow(label: '花軸のタイプ', value: value.rachisType),
        DetailRow(label: '花軸の位置', value: value.rachisPosition),
        DetailRow(label: '花軸の外観', value: value.rachisAppearance),
        DetailRow(label: '雄花蕾のタイプ', value: value.maleBudType),
        DetailRow(label: '雄花蕾の形状', value: value.maleBudShape),
        DetailRow(label: '苞の先端の形状', value: value.bractApexShape),
        DetailRow(label: '苞の重なり方', value: value.bractImbrication),
        DetailRow(label: '苞の外側の色', value: value.bractExternalColour),
        DetailRow(label: '苞の内側の色', value: value.bractInternalColour),
        DetailRow(label: '花軸上の苞痕', value: value.bractScarsOnRachis),
        DetailRow(label: '苞基部の色の退色', value: value.bractBaseColourFading),
        DetailRow(label: '落下前の苞の状態', value: value.bractBehaviourBeforeFalling),
        DetailRow(label: '苞の蝋質', value: value.bractWax),
      ],
    );
  }
}
