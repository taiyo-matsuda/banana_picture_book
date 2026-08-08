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
      title: 'Petiole / Midrib / Leaf',
      children: [
        DetailRow(
          label: 'Petiole canal leaf III',
          value: data.petioleCanalLeafIii,
        ),
        DetailRow(
          label: 'Colour of midrib dorsal surface',
          value: data.midribDorsalSurfaceColour,
        ),
        DetailRow(
          label: 'Colour of cigar leaf dorsal surface',
          value: data.cigarLeafDorsalSurfaceColour,
        ),
        DetailRow(
          label: 'Blotches on leaves of water suckers',
          value: data.waterSuckersLeafBlotches,
        ),
      ],
    );
  }
}
