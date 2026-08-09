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
      title: '分類情報',
      children: [
        BananaDetailInfoRow(
          label: 'MGIS番号',
          value: accession.mgisAccessionNumber,
        ),
        BananaDetailInfoRow(label: '属', value: accession.genus),
        BananaDetailInfoRow(label: '種', value: accession.species.name),
        BananaDetailInfoRow(label: '亜種', value: accession.subspecies.name),
      ],
    );
  }
}
