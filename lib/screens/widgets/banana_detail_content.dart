import 'package:banana_picture_book/screens/widgets/origin_section.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../models/banana_detail.dart';
import 'accession_section.dart';
import 'banana_detail_image_area.dart';
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

                AccessionSection(accession: banana.accession),

                OriginSection(origin: banana.origin),

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
