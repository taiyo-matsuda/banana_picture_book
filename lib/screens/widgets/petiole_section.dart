import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../models/petiole_midrib_leaf.dart';
import 'detail_row.dart';
import 'detail_section.dart';

class PetioleSection extends StatelessWidget {
  const PetioleSection({super.key, required this.leaf});

  final PetioleMidribLeaf? leaf;

  @override
  Widget build(BuildContext context) {
    if (leaf == null) {
      return const SizedBox.shrink();
    }

    final data = leaf!;

    return DetailSection(
      title: '葉柄・中肋・葉',
      children: [
        DetailRow(label: '葉柄の溝（第3葉）', value: data.petioleCanalLeafIii),
        DetailRow(label: '中肋背面の色', value: data.midribDorsalSurfaceColour),
        DetailRow(label: '葉巻葉背面の色', value: data.cigarLeafDorsalSurfaceColour),
        DetailRow(label: '水吸芽の葉の斑点', value: data.waterSuckersLeafBlotches),
      ],
    );
  }
}
