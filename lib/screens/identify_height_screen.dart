import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../models/identification_answer.dart';
import '../../models/plant_height.dart';
import '../../repositories/identification_repository.dart';
import '../../services/identification_session.dart';
import 'widgets/identify/identify_answer_card.dart';
import 'widgets/identify/identify_bottom_action.dart';
import 'widgets/identify/identify_progress_header.dart';

class IdentifyHeightScreen extends StatefulWidget {
  const IdentifyHeightScreen({super.key});

  @override
  State<IdentifyHeightScreen> createState() => _IdentifyHeightScreenState();
}

class _IdentifyHeightScreenState extends State<IdentifyHeightScreen> {
  final _repository = GetIt.instance<IdentificationRepository>();

  final _session = GetIt.instance<IdentificationSession>();

  HeightAnswer? _selectedAnswer;

  List<PlantHeight> _plantHeights = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _selectedAnswer = _session.q1Height;

    _loadPlantHeights();
  }

  Future<void> _loadPlantHeights() async {
    try {
      final heights = await _repository.findPlantHeights();

      if (!mounted) {
        return;
      }

      setState(() {
        _plantHeights = heights;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _errorMessage = 'データを取得できませんでした。';
      });
    }
  }

  bool _hasLowHeight(List<PlantHeight> heights) {
    return heights.any((height) {
      if (height.min == null && height.max == null) {
        return false;
      }

      final min = height.min ?? height.max!;

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
    _session.q1Height = _selectedAnswer;
    context.push('/identify/peel-colour');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          title: const Text('バナナの品種特定'),
          leading: [
            Button(
              style: ButtonStyle(variance: ButtonVariance.ghost),
              onPressed: () => context.pop(),
              child: const Icon(Icons.arrow_back),
            ),
          ],
        ),
      ],
      child: SafeArea(
        child: Column(
          children: [
            const IdentifyProgressHeader(currentStep: 1, totalSteps: 8),

            Expanded(child: _buildContent()),

            IdentifyBottomAction(
              enabled: _selectedAnswer != null,
              onPressed: _next,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

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

          if (_hasLowHeight(_plantHeights)) ...[
            IdentifyAnswerCard(
              title: '低い',
              subtitle: '2.0m以下',
              selected: _selectedAnswer == HeightAnswer.low,
              onTap: () => _selectAnswer(HeightAnswer.low),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasMidHeight(_plantHeights)) ...[
            IdentifyAnswerCard(
              title: '中程度',
              subtitle: '2.1〜2.9m',
              selected: _selectedAnswer == HeightAnswer.mid,
              onTap: () => _selectAnswer(HeightAnswer.mid),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasHighHeight(_plantHeights)) ...[
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
