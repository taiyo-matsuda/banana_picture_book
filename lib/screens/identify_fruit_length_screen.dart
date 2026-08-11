import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/fruit_length.dart';
import '../models/identification_answer.dart';
import '../repositories/identification_repository.dart';
import '../services/identification_session.dart';
import 'widgets/identify/identify_answer_card.dart';
import 'widgets/identify/identify_bottom_action.dart';
import 'widgets/identify/identify_progress_header.dart';

class IdentifyFruitLengthScreen extends StatefulWidget {
  const IdentifyFruitLengthScreen({super.key});

  @override
  State<IdentifyFruitLengthScreen> createState() =>
      _IdentifyFruitLengthScreenState();
}

class _IdentifyFruitLengthScreenState extends State<IdentifyFruitLengthScreen> {
  final _repository = GetIt.instance<IdentificationRepository>();

  final _session = GetIt.instance<IdentificationSession>();

  FruitLengthAnswer? _selectedAnswer;

  List<FruitLength> _fruitLengths = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _selectedAnswer = _session.q5FruitLength;

    _loadFruitLengths();
  }

  Future<void> _loadFruitLengths() async {
    try {
      final fruitLengths = await _repository.findFruitLengths();

      if (!mounted) {
        return;
      }

      setState(() {
        _fruitLengths = fruitLengths;
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

  bool _hasShortLength(List<FruitLength> lengths) {
    return lengths.any((length) => length.max != null && length.max! <= 15);
  }

  bool _hasMediumLength(List<FruitLength> lengths) {
    return lengths.any(
      (length) =>
          length.min != null &&
          length.max != null &&
          length.min! <= 20 &&
          length.max! >= 16,
    );
  }

  bool _hasLongLength(List<FruitLength> lengths) {
    return lengths.any((length) => length.min != null && length.min! >= 21);
  }

  void _selectAnswer(FruitLengthAnswer answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _next() {
    if (_selectedAnswer == null) {
      return;
    }

    _session.q5FruitLength = _selectedAnswer;

    context.push('/identify/fruit-section');
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
            const IdentifyProgressHeader(currentStep: 5, totalSteps: 8),

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
            '果実の長さはどのくらいですか？',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'バナナの果実のおおよその長さを選んでください。',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF71717A),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          if (_hasShortLength(_fruitLengths)) ...[
            IdentifyAnswerCard(
              title: '15cm以下',
              subtitle: '果実の長さが15cm以下',
              selected: _selectedAnswer == FruitLengthAnswer.short,
              onTap: () => _selectAnswer(FruitLengthAnswer.short),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasMediumLength(_fruitLengths)) ...[
            IdentifyAnswerCard(
              title: '16〜20cm',
              subtitle: '果実の長さが16〜20cm',
              selected: _selectedAnswer == FruitLengthAnswer.medium,
              onTap: () => _selectAnswer(FruitLengthAnswer.medium),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasLongLength(_fruitLengths)) ...[
            IdentifyAnswerCard(
              title: '21〜25cm',
              subtitle: '果実の長さが21〜25cm',
              selected: _selectedAnswer == FruitLengthAnswer.long,
              onTap: () => _selectAnswer(FruitLengthAnswer.long),
            ),
            const SizedBox(height: 12),
          ],

          IdentifyAnswerCard(
            title: '不明 / スキップ',
            subtitle: '果実の長さが分からない場合',
            selected: _selectedAnswer == FruitLengthAnswer.unknown,
            onTap: () => _selectAnswer(FruitLengthAnswer.unknown),
          ),
        ],
      ),
    );
  }
}
