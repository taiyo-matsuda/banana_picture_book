import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/banana_detail.dart';
import '../repositories/banana_detail_repository.dart';
import '../repositories/banana_detail_repository_impl.dart';
import './widgets/complementary_section.dart';
import './widgets/fruit_section.dart';
import './widgets/inflorescence_section.dart';
import './widgets/male_flower_section.dart';
import './widgets/petiole_section.dart';
import './widgets/plant_section.dart';

class BananaDetailScreen extends StatefulWidget {
  const BananaDetailScreen({super.key, required this.varietyId});

  final int varietyId;

  @override
  State<BananaDetailScreen> createState() => _BananaDetailScreenState();
}

class _BananaDetailScreenState extends State<BananaDetailScreen> {
  late final BananaDetailRepository _repository;
  late Future<BananaDetail?> _banana;

  @override
  void initState() {
    super.initState();

    _repository = BananaDetailRepositoryImpl(Supabase.instance.client);

    _banana = _repository.findByVarietyId(widget.varietyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [AppBar(title: const Text('バナナ詳細'))],
      child: FutureBuilder<BananaDetail?>(
        future: _banana,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'バナナデータの取得に失敗しました。\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final banana = snapshot.data;

          if (banana == null) {
            return const Center(child: Text('バナナのデータがありません。'));
          }

          return BananaDetailContent(banana: banana);
        },
      ),
    );
  }
}

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
          ImageArea(imageUrl: variety.thumbnailImageUrl),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  variety.canonicalName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  variety.musalogueName,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.mutedForeground,
                  ),
                ),
                const SizedBox(height: 20),
                InfoRow(label: 'ゲノムグループ', value: accession.species.name),
                if (banana.origin.localVernacularName != null)
                  InfoRow(
                    label: '現地名',
                    value: banana.origin.localVernacularName!,
                  ),
                if (banana.origin.origin != null)
                  InfoRow(label: '原産地', value: banana.origin.origin!),
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

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.mutedForeground,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageArea extends StatelessWidget {
  const ImageArea({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: double.infinity,
        height: 280,
        color: Theme.of(context).colorScheme.muted,
        child: const Center(child: Text('🍌', style: TextStyle(fontSize: 72))),
      );
    }

    return Image.network(
      imageUrl!,
      width: double.infinity,
      height: 280,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) {
        return Container(
          width: double.infinity,
          height: 280,
          color: Theme.of(context).colorScheme.muted,
          child: const Center(
            child: Text('🍌', style: TextStyle(fontSize: 72)),
          ),
        );
      },
    );
  }
}
