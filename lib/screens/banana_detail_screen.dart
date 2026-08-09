import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/banana_detail.dart';
import '../repositories/banana_detail_repository.dart';
import '../repositories/banana_detail_repository_impl.dart';
import 'widgets/banana_detail_content.dart';

class BananaDetailScreen extends StatefulWidget {
  const BananaDetailScreen({
    super.key,
    required this.varietyId,
    required this.canonicalName,
  });

  final int varietyId;
  final String? canonicalName;

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
      headers: [AppBar(title: Text(widget.canonicalName ?? 'バナナ詳細'))],
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
