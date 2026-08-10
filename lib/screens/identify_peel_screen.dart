import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../models/identification_answer.dart';
import '../../models/peel_colour.dart';
import '../../repositories/identification_repository.dart';
import '../../services/identification_session.dart';
import 'widgets/identify/identify_answer_card.dart';
import 'widgets/identify/identify_bottom_action.dart';
import 'widgets/identify/identify_progress_header.dart';

class IdentifyPeelScreen extends StatefulWidget {
  const IdentifyPeelScreen({super.key});

  @override
  State<IdentifyPeelScreen> createState() => _IdentifyPeelScreenState();
}

class _IdentifyPeelScreenState extends State<IdentifyPeelScreen> {
  final _repository = GetIt.instance<IdentificationRepository>();

  final _session = GetIt.instance<IdentificationSession>();

  PeelColourAnswer? _selectedAnswer;

  List<PeelColour> _peelColours = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _selectedAnswer = _session.q2PeelColour;

    _loadPeelColours();
  }

  Future<void> _loadPeelColours() async {
    try {
      final colours = await _repository.findPeelColours();

      if (!mounted) {
        return;
      }

      setState(() {
        _peelColours = colours;
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

  bool _hasYellow(List<PeelColour> colours) {
    return colours.any(
      (colour) => colour.value == '黄色' || colour.value == '鮮黄色',
    );
  }

  bool _hasOrange(List<PeelColour> colours) {
    return colours.any((colour) => colour.value == 'オレンジ色');
  }

  bool _hasBlue(List<PeelColour> colours) {
    return colours.any((colour) => colour.value == '青みがかった色');
  }

  void _selectAnswer(PeelColourAnswer answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _next() {
    if (_selectedAnswer == null) {
      return;
    }

    _session.q2PeelColour = _selectedAnswer;

    // TODO: Q3へ
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
            const IdentifyProgressHeader(currentStep: 2, totalSteps: 8),

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
            '熟した果皮の色は何色ですか？',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            '熟したバナナの皮の色を選んでください。',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF71717A),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          if (_hasYellow(_peelColours)) ...[
            IdentifyAnswerCard(
              title: '黄色 / 鮮黄色',
              subtitle: '熟すと黄色になる',
              selected: _selectedAnswer == PeelColourAnswer.yellow,
              onTap: () => _selectAnswer(PeelColourAnswer.yellow),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasOrange(_peelColours)) ...[
            IdentifyAnswerCard(
              title: 'オレンジ色',
              subtitle: '熟すとオレンジ色になる',
              selected: _selectedAnswer == PeelColourAnswer.orange,
              onTap: () => _selectAnswer(PeelColourAnswer.orange),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasBlue(_peelColours)) ...[
            IdentifyAnswerCard(
              title: '青みがかった色',
              subtitle: '熟しても青みが残る',
              selected: _selectedAnswer == PeelColourAnswer.blue,
              onTap: () => _selectAnswer(PeelColourAnswer.blue),
            ),
            const SizedBox(height: 12),
          ],

          IdentifyAnswerCard(
            title: '不明 / スキップ',
            subtitle: '色が分からない場合',
            selected: _selectedAnswer == PeelColourAnswer.unknown,
            onTap: () => _selectAnswer(PeelColourAnswer.unknown),
          ),
        ],
      ),
    );
  }
}
