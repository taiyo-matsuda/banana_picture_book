import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../models/banana_detail.dart';
import 'banana_detail_image_area.dart';
import 'banana_detail_info_row.dart';
import 'complementary_section.dart';
import 'fruit_section.dart';
import 'inflorescence_section.dart';
import 'male_flower_section.dart';
import 'petiole_section.dart';
import 'plant_section.dart';

class BananaDetailContent extends StatelessWidget {
  const BananaDetailContent({super.key, required this.banana});

  final BananaDetail banana;

  @override
  Widget build(BuildContext context) {
    final variety = banana.variety;
    final accession = banana.accession;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BananaDetailImageArea(imageUrl: variety.thumbnailImageUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),

                Text(
                  variety.musalogueName,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.mutedForeground,
                  ),
                ),

                const SizedBox(height: 20),

                BananaDetailInfoRow(
                  label: 'ゲノムグループ',
                  value: accession.species.name,
                ),

                if (banana.origin.localVernacularName != null)
                  BananaDetailInfoRow(
                    label: '現地名',
                    value: banana.origin.localVernacularName!,
                  ),

                if (banana.origin.origin != null)
                  BananaDetailInfoRow(
                    label: '原産地',
                    value: banana.origin.origin!,
                  ),

                const SizedBox(height: 24),

                PlantSection(plantTrait: banana.plantTrait),

                MaleFlowerSection(maleFlower: banana.maleFlower),

                PetioleSection(leaf: banana.petioleMidribLeaf),

                InflorescenceSection(data: banana.inflorescenceMaleBud),

                FruitSection(fruit: banana.fruit),

                ComplementarySection(items: banana.complementary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
