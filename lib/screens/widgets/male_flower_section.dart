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
      title: 'Male flower',
      children: [
        DetailRow(
          label: 'Compound tepal basic colour',
          value: data.compoundTepalBasicColour,
        ),
        DetailRow(
          label: 'Compound tepal pigmentation',
          value: data.compoundTepalPigmentation,
        ),
        DetailRow(
          label: 'Lobe colour of compound tepal',
          value: data.compoundTepalLobeColour,
        ),
        DetailRow(
          label: 'Free tepal appearance',
          value: data.freeTepalAppearance,
        ),
        DetailRow(label: 'Style shape', value: data.styleShape),
        DetailRow(label: 'Stigma colour', value: data.stigmaColour),
        DetailRow(label: 'Ovary basic colour', value: data.ovaryBasicColour),
        DetailRow(label: 'Ovary pigmentation', value: data.ovaryPigmentation),
      ],
    );
  }
}
