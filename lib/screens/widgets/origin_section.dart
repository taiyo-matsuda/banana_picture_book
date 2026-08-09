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
      title: '原産地情報',
      children: [
        BananaDetailInfoRow(label: '原産地', value: origin.origin),
        BananaDetailInfoRow(label: '州・県', value: origin.province),
        BananaDetailInfoRow(label: '詳細な採集地', value: origin.exactLocation),
        BananaDetailInfoRow(label: '採集元', value: origin.collectingSource),
        BananaDetailInfoRow(label: '現地名', value: origin.localVernacularName),
        BananaDetailInfoRow(label: '識別番号', value: origin.accessionCode),
        BananaDetailInfoRow(label: '用途', value: uses.isEmpty ? null : uses),
      ],
    );
  }
}
