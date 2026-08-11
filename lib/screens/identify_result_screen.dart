import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/identification_result.dart';
import '../repositories/identification_repository.dart';
import '../services/identification_scorer.dart';
import '../services/identification_session.dart';

class IdentifyResultScreen extends StatefulWidget {
  const IdentifyResultScreen({super.key});

  @override
  State<IdentifyResultScreen> createState() => _IdentifyResultScreenState();
}

class _IdentifyResultScreenState extends State<IdentifyResultScreen> {
  final _repository = GetIt.instance<IdentificationRepository>();

  final _session = GetIt.instance<IdentificationSession>();

  final _scorer = GetIt.instance<IdentificationScorer>();

  late Future<List<IdentificationResult>> _results;

  @override
  void initState() {
    super.initState();

    _results = _loadResults();
  }

  Future<List<IdentificationResult>> _loadResults() async {
    final candidates = await _repository.findCandidates();

    return _scorer.score(session: _session, candidates: candidates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [AppBar(title: const Text('特定結果'))],
      child: SafeArea(
        child: FutureBuilder<List<IdentificationResult>>(
          future: _results,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    '結果の取得に失敗しました。\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final results = snapshot.data ?? [];

            if (results.isEmpty) {
              return const Center(child: Text('候補となる品種がありません。'));
            }

            return _ResultContent(results: results);
          },
        ),
      ),
    );
  }
}

class _ResultContent extends StatelessWidget {
  const _ResultContent({required this.results});

  final List<IdentificationResult> results;

  @override
  Widget build(BuildContext context) {
    final topResults = results.take(5).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '特定結果',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 8),

          const Text(
            '回答した特徴との一致度が高い順に表示しています。',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF71717A),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 28),

          ...List.generate(topResults.length, (index) {
            final result = topResults[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ResultCard(result: result, rank: index + 1),
            );
          }),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: Button(
              style: const ButtonStyle(variance: ButtonVariance.outline),
              onPressed: () {
                context.go('/identify');
              },
              child: const Text('もう一度特定する'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result, required this.rank});

  final IdentificationResult result;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final candidate = result.candidate;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F5),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                '$rank',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    candidate.canonicalName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  if (candidate.musalogueName != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      candidate.musalogueName!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF71717A),
                      ),
                    ),
                  ],

                  const SizedBox(height: 12),

                  Text(
                    '${result.matchRate.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '${result.score} / ${result.maxScore} 点',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF71717A),
                    ),
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
