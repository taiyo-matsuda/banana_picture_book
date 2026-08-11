import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/identification_result.dart';
import '../services/identification_scorer.dart';
import '../services/identification_session.dart';

class IdentifyResultScreen extends StatelessWidget {
  const IdentifyResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = GetIt.instance<IdentificationSession>();

    final scorer = GetIt.instance<IdentificationScorer>();

    final candidates = GetIt.instance<IdentificationCandidates>();

    final results = scorer.score(
      session: session,
      candidates: candidates.items,
    );

    return Scaffold(
      headers: [AppBar(title: const Text('特定結果'))],
      child: SafeArea(child: _buildContent(context, results)),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<IdentificationResult> results,
  ) {
    if (results.isEmpty) {
      return const Center(child: Text('候補となる品種がありません。'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
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
            style: TextStyle(fontSize: 15, color: Color(0xFF71717A)),
          ),

          const SizedBox(height: 28),

          ...results
              .take(5)
              .map(
                (result) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ResultCard(
                    result: result,
                    rank: results.indexOf(result) + 1,
                  ),
                ),
              ),

          const SizedBox(height: 20),

          Button(
            style: const ButtonStyle(variance: ButtonVariance.outline),
            onPressed: () {
              context.go('/identify');
            },
            child: const Text('もう一度特定する'),
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
    final banana = result.candidate;

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
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    banana.canonicalName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  if (banana.musalogueName != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      banana.musalogueName!,
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
