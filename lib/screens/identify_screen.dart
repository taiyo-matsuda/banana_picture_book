import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'widgets/identify/identification_feature_row.dart';

class IdentifyScreen extends StatelessWidget {
  const IdentifyScreen({super.key});

  void _startIdentification(BuildContext context) {
    context.push('/identify/height');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [AppBar(title: const Text('バナナの品種特定'))],
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Center(child: Text('🍌', style: TextStyle(fontSize: 72))),

              const SizedBox(height: 32),

              const Text(
                'バナナの品種を\n特定してみましょう',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                '株の高さや果実の特徴など、'
                '8つの質問に答えることで、'
                '特徴が近いバナナ品種を判定します。',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF71717A),
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 32),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '特定の流れ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      IdentificationFeatureRow(
                        number: '1',
                        title: '8つの質問に回答',
                        description: '分かる範囲で特徴を選択します。',
                      ),
                      const SizedBox(height: 16),
                      IdentificationFeatureRow(
                        number: '2',
                        title: '品種を照合',
                        description: 'データベースの品種情報と照合します。',
                      ),
                      const SizedBox(height: 16),
                      IdentificationFeatureRow(
                        number: '3',
                        title: '候補を表示',
                        description: '一致度の高い品種を候補として表示します。',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                '分からない特徴は「不明 / スキップ」を選択できます。',
                style: TextStyle(fontSize: 14, color: Color(0xFF71717A)),
              ),

              Button(
                style: ButtonStyle(variance: ButtonVariance.primary),
                onPressed: () => _startIdentification(context),
                child: const Text('特定を開始'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
