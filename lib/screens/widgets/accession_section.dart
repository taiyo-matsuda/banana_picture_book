import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../models/accession.dart';
import 'banana_detail_info_row.dart';
import 'detail_section.dart';

class AccessionSection extends StatelessWidget {
  const AccessionSection({super.key, required this.accession});

  final Accession accession;

  @override
  Widget build(BuildContext context) {
    return DetailSection(
      title: 'Accession',
      children: [
        BananaDetailInfoRow(
          label: 'MGIS accession number',
          value: accession.mgisAccessionNumber,
        ),
        BananaDetailInfoRow(label: 'Genus', value: accession.genus),
        BananaDetailInfoRow(label: 'Species', value: accession.species.name),
        BananaDetailInfoRow(
          label: 'Subspecies',
          value: accession.subspecies.name,
        ),
      ],
    );
  }
}
