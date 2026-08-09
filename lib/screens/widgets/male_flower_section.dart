import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../models/male_flower.dart';
import 'detail_row.dart';
import 'detail_section.dart';

class MaleFlowerSection extends StatelessWidget {
  const MaleFlowerSection({super.key, required this.maleFlower});

  final MaleFlower? maleFlower;

  @override
  Widget build(BuildContext context) {
    if (maleFlower == null) {
      return const SizedBox.shrink();
    }

    final data = maleFlower!;

    return DetailSection(
      title: '雄花',
      children: [
        DetailRow(label: '複合花被の基本色', value: data.compoundTepalBasicColour),
        DetailRow(label: '複合花被の着色', value: data.compoundTepalPigmentation),
        DetailRow(label: '複合花被の裂片の色', value: data.compoundTepalLobeColour),
        DetailRow(label: '離生花被の外観', value: data.freeTepalAppearance),
        DetailRow(label: '花柱の形状', value: data.styleShape),
        DetailRow(label: '柱頭の色', value: data.stigmaColour),
        DetailRow(label: '子房の基本色', value: data.ovaryBasicColour),
        DetailRow(label: '子房の着色', value: data.ovaryPigmentation),
      ],
    );
  }
}
