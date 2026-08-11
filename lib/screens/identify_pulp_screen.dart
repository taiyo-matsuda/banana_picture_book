import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/identification_answer.dart';
import '../models/pulp_colour.dart';
import '../repositories/identification_repository.dart';
import '../services/identification_session.dart';
import 'widgets/identify/identify_answer_card.dart';
import 'widgets/identify/identify_bottom_action.dart';
import 'widgets/identify/identify_progress_header.dart';

class IdentifyPulpScreen extends StatefulWidget {
  const IdentifyPulpScreen({super.key});

  @override
  State<IdentifyPulpScreen> createState() => _IdentifyPulpScreenState();
}

class _IdentifyPulpScreenState extends State<IdentifyPulpScreen> {
  final _repository = GetIt.instance<IdentificationRepository>();
  final _session = GetIt.instance<IdentificationSession>();

  PulpColourAnswer? _selectedAnswer;

  List<PulpColour> _pulpColours = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _selectedAnswer = _session.q3PulpColour;

    _loadPulpColours();
  }

  Future<void> _loadPulpColours() async {
    try {
      final colours = await _repository.findPulpColours();

      if (!mounted) {
        return;
      }

      setState(() {
        _pulpColours = colours;
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

  bool _hasIvory(List<PulpColour> colours) {
    return colours.any((colour) => colour.value == 'アイボリー');
  }

  bool _hasCream(List<PulpColour> colours) {
    return colours.any((colour) => colour.value == 'クリーム色');
  }

  bool _hasWhite(List<PulpColour> colours) {
    return colours.any((colour) => colour.value == '白色');
  }

  bool _hasYellow(List<PulpColour> colours) {
    return colours.any((colour) => colour.value == '黄色');
  }

  void _selectAnswer(PulpColourAnswer answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _next() {
    if (_selectedAnswer == null) {
      return;
    }

    _session.q3PulpColour = _selectedAnswer;

    context.push('/identify/fruit-apex');
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
            const IdentifyProgressHeader(currentStep: 3, totalSteps: 8),

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
            '熟した果肉の色は何色ですか？',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            '熟したバナナの果肉の色を選んでください。',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF71717A),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          if (_hasIvory(_pulpColours)) ...[
            IdentifyAnswerCard(
              title: 'アイボリー',
              subtitle: '熟すとアイボリー色になる',
              selected: _selectedAnswer == PulpColourAnswer.ivory,
              onTap: () => _selectAnswer(PulpColourAnswer.ivory),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasCream(_pulpColours)) ...[
            IdentifyAnswerCard(
              title: 'クリーム色',
              subtitle: '熟すとクリーム色になる',
              selected: _selectedAnswer == PulpColourAnswer.cream,
              onTap: () => _selectAnswer(PulpColourAnswer.cream),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasWhite(_pulpColours)) ...[
            IdentifyAnswerCard(
              title: '白色',
              subtitle: '熟すと白色になる',
              selected: _selectedAnswer == PulpColourAnswer.white,
              onTap: () => _selectAnswer(PulpColourAnswer.white),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasYellow(_pulpColours)) ...[
            IdentifyAnswerCard(
              title: '黄色',
              subtitle: '熟すと黄色になる',
              selected: _selectedAnswer == PulpColourAnswer.yellow,
              onTap: () => _selectAnswer(PulpColourAnswer.yellow),
            ),
            const SizedBox(height: 12),
          ],

          IdentifyAnswerCard(
            title: '不明 / スキップ',
            subtitle: '果肉の色が分からない場合',
            selected: _selectedAnswer == PulpColourAnswer.unknown,
            onTap: () => _selectAnswer(PulpColourAnswer.unknown),
          ),
        ],
      ),
    );
  }
}
