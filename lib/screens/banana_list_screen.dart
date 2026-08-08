import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('バナナ図鑑')),
      body: FutureBuilder<List<BriefBanana>>(
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

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: bananas.length,
            itemBuilder: (context, index) {
              final banana = bananas[index];

              return _BananaCard(banana: banana);
            },
          );
        },
      ),
    );
  }
}

class _BananaCard extends StatelessWidget {
  const _BananaCard({required this.banana});

  final BriefBanana banana;

  @override
  Widget build(BuildContext context) {
    final uses = [
      if (banana.origin.useForDessert) '生食用',
      if (banana.origin.useForCooking) '調理用',
    ].join(' · ');

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: const Center(
                child: Text('🍌', style: TextStyle(fontSize: 56)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 品種名
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

                // 学名
                Text(
                  banana.variety.musalogueName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),

                // ゲノムグループ / 用途
                Row(
                  children: [
                    Text(
                      'ゲノムグループ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                      Text(
                        '用途',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
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
    );
  }
}
