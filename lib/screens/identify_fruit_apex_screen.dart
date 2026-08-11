import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/fruit_apex.dart';
import '../models/identification_answer.dart';
import '../repositories/identification_repository.dart';
import '../services/identification_session.dart';
import 'widgets/identify/identify_answer_card.dart';
import 'widgets/identify/identify_bottom_action.dart';
import 'widgets/identify/identify_progress_header.dart';

class IdentifyFruitApexScreen extends StatefulWidget {
  const IdentifyFruitApexScreen({super.key});

  @override
  State<IdentifyFruitApexScreen> createState() =>
      _IdentifyFruitApexScreenState();
}

class _IdentifyFruitApexScreenState extends State<IdentifyFruitApexScreen> {
  final _repository = GetIt.instance<IdentificationRepository>();
  final _session = GetIt.instance<IdentificationSession>();

  FruitApexAnswer? _selectedAnswer;

  List<FruitApex> _fruitApexes = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _selectedAnswer = _session.q4FruitApex;

    _loadFruitApexes();
  }

  Future<void> _loadFruitApexes() async {
    try {
      final fruitApexes = await _repository.findFruitApexes();

      if (!mounted) {
        return;
      }

      setState(() {
        _fruitApexes = fruitApexes;
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

  bool _hasPointed(List<FruitApex> apexes) {
    return apexes.any((apex) => apex.value == '尖っている');
  }

  bool _hasBottleNeck(List<FruitApex> apexes) {
    return apexes.any((apex) => apex.value == '瓶の首状');
  }

  bool _hasLongPointed(List<FruitApex> apexes) {
    return apexes.any((apex) => apex.value == '細長く尖っている');
  }

  bool _hasBlunt(List<FruitApex> apexes) {
    return apexes.any((apex) => apex.value == '鈍い先端');
  }

  void _selectAnswer(FruitApexAnswer answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _next() {
    if (_selectedAnswer == null) {
      return;
    }

    _session.q4FruitApex = _selectedAnswer;

    context.push('/identify/fruit-length');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          title: const Text('バナナの品種特定'),
          leading: [
            IconButton(
              variance: ButtonVariance.ghost,
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
      ],
      child: SafeArea(
        child: Column(
          children: [
            const IdentifyProgressHeader(currentStep: 4, totalSteps: 8),

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
            '果実の先端はどのような形ですか？',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'バナナの果実の先端の形を選んでください。',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF71717A),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          if (_hasPointed(_fruitApexes)) ...[
            IdentifyAnswerCard(
              title: '尖っている',
              subtitle: '先端が尖った形',
              selected: _selectedAnswer == FruitApexAnswer.pointed,
              onTap: () => _selectAnswer(FruitApexAnswer.pointed),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasBottleNeck(_fruitApexes)) ...[
            IdentifyAnswerCard(
              title: '瓶の首状',
              subtitle: '瓶の首のようにくびれた形',
              selected: _selectedAnswer == FruitApexAnswer.bottleNeck,
              onTap: () => _selectAnswer(FruitApexAnswer.bottleNeck),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasLongPointed(_fruitApexes)) ...[
            IdentifyAnswerCard(
              title: '細長く尖っている',
              subtitle: '細長く伸びた尖った形',
              selected: _selectedAnswer == FruitApexAnswer.longPointed,
              onTap: () => _selectAnswer(FruitApexAnswer.longPointed),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasBlunt(_fruitApexes)) ...[
            IdentifyAnswerCard(
              title: '鈍い先端',
              subtitle: '先端が丸みを帯びた形',
              selected: _selectedAnswer == FruitApexAnswer.blunt,
              onTap: () => _selectAnswer(FruitApexAnswer.blunt),
            ),
            const SizedBox(height: 12),
          ],

          IdentifyAnswerCard(
            title: '不明 / スキップ',
            subtitle: '果実の先端が分からない場合',
            selected: _selectedAnswer == FruitApexAnswer.unknown,
            onTap: () => _selectAnswer(FruitApexAnswer.unknown),
          ),
        ],
      ),
    );
  }
}
