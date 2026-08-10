import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/identification_answer.dart';
import '../models/plant_height.dart';
import '../repositories/identification_repository.dart';
import 'widgets/identify/identify_answer_card.dart';
import 'widgets/identify/identify_bottom_action.dart';
import 'widgets/identify/identify_progress_header.dart';

class IdentifyHeightScreen extends StatefulWidget {
  const IdentifyHeightScreen({super.key, required this.repository});

  final IdentificationRepository repository;

  @override
  State<IdentifyHeightScreen> createState() => _IdentifyHeightScreenState();
}

class _IdentifyHeightScreenState extends State<IdentifyHeightScreen> {
  late Future<List<PlantHeight>> _plantHeights;

  HeightAnswer? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _plantHeights = widget.repository.findPlantHeights();
  }

  bool _hasLowHeight(List<PlantHeight> heights) {
    return heights.any((height) {
      if (height.min == null && height.max == null) {
        return false;
      }

      final min = height.min ?? height.max!;
      final max = height.max ?? height.min!;

      return min <= 2.0;
    });
  }

  bool _hasMidHeight(List<PlantHeight> heights) {
    return heights.any((height) {
      if (height.min == null && height.max == null) {
        return false;
      }

      final min = height.min ?? height.max!;
      final max = height.max ?? height.min!;

      return min <= 2.9 && max >= 2.1;
    });
  }

  bool _hasHighHeight(List<PlantHeight> heights) {
    return heights.any((height) {
      if (height.min == null && height.max == null) {
        return false;
      }

      final min = height.min ?? height.max!;
      final max = height.max ?? height.min!;

      return max >= 3.0;
    });
  }

  void _selectAnswer(HeightAnswer answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _next() {
    if (_selectedAnswer == null) {
      return;
    }

    debugPrint('Q1 answer: $_selectedAnswer');

    // TODO: Q2ページへ遷移
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [AppBar(title: const Text('バナナの品種特定'))],
      child: Column(
        children: [
          const IdentifyProgressHeader(currentStep: 1, totalSteps: 8),
          Expanded(
            child: FutureBuilder<List<PlantHeight>>(
              future: _plantHeights,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'バナナデータの取得に失敗しました。\n'
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final heights = snapshot.data ?? [];

                if (heights.isEmpty) {
                  return const Center(child: Text('高さのデータがありません。'));
                }

                return _buildContent(heights);
              },
            ),
          ),
          IdentifyBottomAction(
            enabled: _selectedAnswer != null,
            onPressed: _next,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<PlantHeight> heights) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '株（木）の高さはどのくらいですか？',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'バナナの株全体のおおよその高さを選んでください。',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF71717A),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F5),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: const Text(
              '高さ比較イラスト',
              style: TextStyle(color: Color(0xFF71717A)),
            ),
          ),
          const SizedBox(height: 32),
          if (_hasLowHeight(heights)) ...[
            IdentifyAnswerCard(
              title: '低い',
              subtitle: '2.0m以下',
              selected: _selectedAnswer == HeightAnswer.low,
              onTap: () => _selectAnswer(HeightAnswer.low),
            ),
            const SizedBox(height: 12),
          ],
          if (_hasMidHeight(heights)) ...[
            IdentifyAnswerCard(
              title: '中程度',
              subtitle: '2.1〜2.9m',
              selected: _selectedAnswer == HeightAnswer.mid,
              onTap: () => _selectAnswer(HeightAnswer.mid),
            ),
            const SizedBox(height: 12),
          ],
          if (_hasHighHeight(heights)) ...[
            IdentifyAnswerCard(
              title: '高い',
              subtitle: '3.0m以上',
              selected: _selectedAnswer == HeightAnswer.high,
              onTap: () => _selectAnswer(HeightAnswer.high),
            ),
            const SizedBox(height: 12),
          ],
          IdentifyAnswerCard(
            title: '不明 / スキップ',
            subtitle: '高さが分からない場合',
            selected: _selectedAnswer == HeightAnswer.unknown,
            onTap: () => _selectAnswer(HeightAnswer.unknown),
          ),
        ],
      ),
    );
  }
}
