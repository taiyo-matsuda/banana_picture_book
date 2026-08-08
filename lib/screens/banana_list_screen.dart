import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/brief_banana.dart';
import '../repositories/brief_banana_repository.dart';

class BananaListScreen extends StatefulWidget {
  const BananaListScreen({super.key, required this.repository});

  final BriefBananaRepository repository;

  @override
  State<BananaListScreen> createState() => _BananaListScreenState();
}

class _BananaListScreenState extends State<BananaListScreen> {
  late Future<List<BriefBanana>> _bananas;

  @override
  void initState() {
    super.initState();
    _bananas = widget.repository.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [AppBar(title: const Text('バナナ図鑑'))],
      child: FutureBuilder<List<BriefBanana>>(
        future: _bananas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'バナナデータの取得に失敗しました。\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final bananas = snapshot.data ?? [];

          if (bananas.isEmpty) {
            return const Center(child: Text('バナナのデータがありません。'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bananas.length,
            itemBuilder: (context, index) {
              final banana = bananas[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _BananaCard(
                  banana: banana,
                  onTap: () {
                    context.push('/bananas/${banana.variety.id}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _BananaCard extends StatelessWidget {
  const _BananaCard({required this.banana, required this.onTap});

  final BriefBanana banana;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final uses = [
      if (banana.origin.useForDessert) '生食用',
      if (banana.origin.useForCooking) '調理用',
    ].join(' · ');

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              decoration: const BoxDecoration(color: Color(0xFFF3F4F6)),
              child: const Center(
                child: Text('🍌', style: TextStyle(fontSize: 56)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    banana.variety.canonicalName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    banana.variety.musalogueName,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Text(
                        'ゲノムグループ',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(width: 6),

                      Text(
                        banana.accession.species.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      if (uses.isNotEmpty) ...[
                        const SizedBox(width: 20),

                        const Text(
                          '用途',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: Text(
                            uses,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
