import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/identification_answer.dart';
import '../models/sap_colour.dart';
import '../repositories/identification_repository.dart';
import '../services/identification_session.dart';
import 'widgets/identify/identify_answer_card.dart';
import 'widgets/identify/identify_bottom_action.dart';
import 'widgets/identify/identify_progress_header.dart';

class IdentifySapColourScreen extends StatefulWidget {
  const IdentifySapColourScreen({super.key});

  @override
  State<IdentifySapColourScreen> createState() =>
      _IdentifySapColourScreenState();
}

class _IdentifySapColourScreenState extends State<IdentifySapColourScreen> {
  final _repository = GetIt.instance<IdentificationRepository>();

  final _session = GetIt.instance<IdentificationSession>();

  SapColourAnswer? _selectedAnswer;

  List<SapColour> _sapColours = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _selectedAnswer = _session.q8SapColour;

    _loadSapColours();
  }

  Future<void> _loadSapColours() async {
    try {
      final colours = await _repository.findSapColours();

      if (!mounted) {
        return;
      }

      setState(() {
        _sapColours = colours;
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
    return _sapColours.any((colour) => colour.value == value);
  }

  void _selectAnswer(SapColourAnswer answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _finish() {
    if (_selectedAnswer == null) {
      return;
    }

    _session.q8SapColour = _selectedAnswer;

    context.push('/identify/result');
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
            const IdentifyProgressHeader(currentStep: 8, totalSteps: 8),

            Expanded(child: _buildContent()),

            IdentifyBottomAction(
              enabled: _selectedAnswer != null,
              onPressed: _finish,
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
            '樹液の色はどのような色ですか？',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            '切り口などから出る樹液の色や状態を選んでください。',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF71717A),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          if (_hasValue('乳白色')) ...[
            IdentifyAnswerCard(
              title: '乳白色',
              subtitle: '白く濁った樹液',
              selected: _selectedAnswer == SapColourAnswer.milkyWhite,
              onTap: () => _selectAnswer(SapColourAnswer.milkyWhite),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasValue('水様')) ...[
            IdentifyAnswerCard(
              title: '水様',
              subtitle: '水のように透明に近い樹液',
              selected: _selectedAnswer == SapColourAnswer.watery,
              onTap: () => _selectAnswer(SapColourAnswer.watery),
            ),
            const SizedBox(height: 12),
          ],

          IdentifyAnswerCard(
            title: '不明 / スキップ',
            subtitle: '樹液の色や状態が分からない場合',
            selected: _selectedAnswer == SapColourAnswer.unknown,
            onTap: () => _selectAnswer(SapColourAnswer.unknown),
          ),
        ],
      ),
    );
  }
}
