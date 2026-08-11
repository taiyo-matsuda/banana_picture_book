import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/fruit_transverse_section.dart';
import '../models/identification_answer.dart';
import '../repositories/identification_repository.dart';
import '../services/identification_session.dart';
import 'widgets/identify/identify_answer_card.dart';
import 'widgets/identify/identify_bottom_action.dart';
import 'widgets/identify/identify_progress_header.dart';

class IdentifyFruitTransverseSectionScreen extends StatefulWidget {
  const IdentifyFruitTransverseSectionScreen({super.key});

  @override
  State<IdentifyFruitTransverseSectionScreen> createState() =>
      _IdentifyFruitTransverseSectionScreenState();
}

class _IdentifyFruitTransverseSectionScreenState
    extends State<IdentifyFruitTransverseSectionScreen> {
  final _repository = GetIt.instance<IdentificationRepository>();

  final _session = GetIt.instance<IdentificationSession>();

  FruitTransverseSectionAnswer? _selectedAnswer;

  List<FruitTransverseSection> _sections = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _selectedAnswer = _session.q6FruitTransverseSection;

    _loadSections();
  }

  Future<void> _loadSections() async {
    try {
      final sections = await _repository.findFruitTransverseSections();

      if (!mounted) {
        return;
      }

      setState(() {
        _sections = sections;
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

  bool _hasValue(String value) {
    return _sections.any((section) => section.value == value);
  }

  void _selectAnswer(FruitTransverseSectionAnswer answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _next() {
    if (_selectedAnswer == null) {
      return;
    }

    _session.q6FruitTransverseSection = _selectedAnswer;

    context.push('/identify/fruit-axis-hair');
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
            const IdentifyProgressHeader(currentStep: 6, totalSteps: 8),

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
            '果実の断面はどのような形ですか？',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            '果実を横に切ったときの断面の形を選んでください。',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF71717A),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          if (_hasValue('丸い')) ...[
            IdentifyAnswerCard(
              title: '丸い',
              subtitle: '断面が丸みを帯びている',
              selected: _selectedAnswer == FruitTransverseSectionAnswer.round,
              onTap: () => _selectAnswer(FruitTransverseSectionAnswer.round),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasValue('明瞭な稜')) ...[
            IdentifyAnswerCard(
              title: '明瞭な稜',
              subtitle: '断面の稜がはっきりしている',
              selected:
                  _selectedAnswer ==
                  FruitTransverseSectionAnswer.pronouncedRidges,
              onTap: () =>
                  _selectAnswer(FruitTransverseSectionAnswer.pronouncedRidges),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasValue('やや稜状')) ...[
            IdentifyAnswerCard(
              title: 'やや稜状',
              subtitle: '断面にやや稜がある',
              selected:
                  _selectedAnswer ==
                  FruitTransverseSectionAnswer.slightlyRidged,
              onTap: () =>
                  _selectAnswer(FruitTransverseSectionAnswer.slightlyRidged),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasValue('わずかに稜がある')) ...[
            IdentifyAnswerCard(
              title: 'わずかに稜がある',
              subtitle: '断面にわずかな稜がある',
              selected:
                  _selectedAnswer == FruitTransverseSectionAnswer.faintRidges,
              onTap: () =>
                  _selectAnswer(FruitTransverseSectionAnswer.faintRidges),
            ),
            const SizedBox(height: 12),
          ],

          IdentifyAnswerCard(
            title: '不明 / スキップ',
            subtitle: '断面の形が分からない場合',
            selected: _selectedAnswer == FruitTransverseSectionAnswer.unknown,
            onTap: () => _selectAnswer(FruitTransverseSectionAnswer.unknown),
          ),
        ],
      ),
    );
  }
}
