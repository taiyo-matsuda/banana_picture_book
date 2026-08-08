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
      title: 'Inflorescence / Male bud',
      children: [
        DetailRow(
          label: 'Peduncle length',
          value: range(value.peduncleLengthMin, value.peduncleLengthMax),
        ),
        DetailRow(label: 'Peduncle hairiness', value: value.peduncleHairiness),
        DetailRow(label: 'Bunch position', value: value.bunchPosition),
        DetailRow(label: 'Rachis type', value: value.rachisType),
        DetailRow(label: 'Rachis position', value: value.rachisPosition),
        DetailRow(label: 'Rachis appearance', value: value.rachisAppearance),
        DetailRow(label: 'Male bud type', value: value.maleBudType),
        DetailRow(label: 'Male bud shape', value: value.maleBudShape),
        DetailRow(label: 'Bract apex shape', value: value.bractApexShape),
        DetailRow(label: 'Bract imbrication', value: value.bractImbrication),
        DetailRow(
          label: 'Bract external colour',
          value: value.bractExternalColour,
        ),
        DetailRow(
          label: 'Bract internal colour',
          value: value.bractInternalColour,
        ),
        DetailRow(
          label: 'Bract scars on rachis',
          value: value.bractScarsOnRachis,
        ),
        DetailRow(
          label: 'Bract base colour fading',
          value: value.bractBaseColourFading,
        ),
        DetailRow(
          label: 'Bract behaviour before falling',
          value: value.bractBehaviourBeforeFalling,
        ),
        DetailRow(label: 'Bract wax', value: value.bractWax),
      ],
    );
  }
}
