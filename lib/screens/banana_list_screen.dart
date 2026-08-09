import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/brief_banana.dart';
import '../repositories/brief_banana_repository.dart';
import 'widgets/banana_card.dart';

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
                child: BananaCard(
                  banana: banana,
                  onTap: () {
                    context.push(
                      '/bananas/${banana.variety.id}',
                      extra: banana.variety.canonicalName,
                    );
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
