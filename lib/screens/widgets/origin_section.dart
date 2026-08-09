import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../models/origin.dart';
import 'banana_detail_info_row.dart';
import 'detail_section.dart';

class OriginSection extends StatelessWidget {
  const OriginSection({super.key, required this.origin});

  final Origin origin;

  @override
  Widget build(BuildContext context) {
    final uses = [
      if (origin.useForDessert) '生食用',
      if (origin.useForCooking) '調理用',
    ].join(' · ');

    return DetailSection(
      title: 'Origin',
      children: [
        BananaDetailInfoRow(label: 'Origin', value: origin.origin),
        BananaDetailInfoRow(label: 'Province', value: origin.province),
        BananaDetailInfoRow(
          label: 'Exact location',
          value: origin.exactLocation,
        ),
        BananaDetailInfoRow(
          label: 'Collecting source',
          value: origin.collectingSource,
        ),
        BananaDetailInfoRow(
          label: 'Local vernacular name',
          value: origin.localVernacularName,
        ),
        BananaDetailInfoRow(
          label: 'Accession code',
          value: origin.accessionCode,
        ),
        BananaDetailInfoRow(label: 'Use', value: uses.isEmpty ? null : uses),
      ],
    );
  }
}
