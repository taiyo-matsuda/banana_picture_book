import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../models/identification_answer.dart';
import '../models/peduncle_hairiness.dart';
import '../repositories/identification_repository.dart';
import '../services/identification_session.dart';
import 'widgets/identify/identify_answer_card.dart';
import 'widgets/identify/identify_bottom_action.dart';
import 'widgets/identify/identify_progress_header.dart';

class IdentifyPeduncleHairinessScreen extends StatefulWidget {
  const IdentifyPeduncleHairinessScreen({super.key});

  @override
  State<IdentifyPeduncleHairinessScreen> createState() =>
      _IdentifyPeduncleHairinessScreenState();
}

class _IdentifyPeduncleHairinessScreenState
    extends State<IdentifyPeduncleHairinessScreen> {
  final _repository = GetIt.instance<IdentificationRepository>();

  final _session = GetIt.instance<IdentificationSession>();

  PeduncleHairinessAnswer? _selectedAnswer;

  List<PeduncleHairiness> _hairiness = [];

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _selectedAnswer = _session.q7PeduncleHairiness;

    _loadHairiness();
  }

  Future<void> _loadHairiness() async {
    try {
      final hairiness = await _repository.findPeduncleHairiness();

      if (!mounted) {
        return;
      }

      setState(() {
        _hairiness = hairiness;
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
    return _hairiness.any((item) => item.value == value);
  }

  void _selectAnswer(PeduncleHairinessAnswer answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _next() {
    if (_selectedAnswer == null) {
      return;
    }

    _session.q7PeduncleHairiness = _selectedAnswer;

    context.push('/identify/sap-colour');
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
            const IdentifyProgressHeader(currentStep: 7, totalSteps: 8),

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
            '果軸には毛がありますか？',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            '果軸（花序の軸）の毛の状態を選んでください。',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF71717A),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 32),

          if (_hasValue('無毛')) ...[
            IdentifyAnswerCard(
              title: '無毛',
              subtitle: '毛がない',
              selected: _selectedAnswer == PeduncleHairinessAnswer.hairless,
              onTap: () => _selectAnswer(PeduncleHairinessAnswer.hairless),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasValue('非常に毛深い、長い毛（2mm超）')) ...[
            IdentifyAnswerCard(
              title: '非常に毛深い',
              subtitle: '長い毛（2mm超）',
              selected:
                  _selectedAnswer == PeduncleHairinessAnswer.veryHairyLong,
              onTap: () => _selectAnswer(PeduncleHairinessAnswer.veryHairyLong),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasValue('やや毛深い')) ...[
            IdentifyAnswerCard(
              title: 'やや毛深い',
              subtitle: '毛が少し生えている',
              selected:
                  _selectedAnswer == PeduncleHairinessAnswer.slightlyHairy,
              onTap: () => _selectAnswer(PeduncleHairinessAnswer.slightlyHairy),
            ),
            const SizedBox(height: 12),
          ],

          if (_hasValue('非常に毛深い、短い毛（ビロードのような手触り）')) ...[
            IdentifyAnswerCard(
              title: '非常に毛深い',
              subtitle: '短い毛（ビロードのような手触り）',
              selected:
                  _selectedAnswer == PeduncleHairinessAnswer.veryHairyShort,
              onTap: () =>
                  _selectAnswer(PeduncleHairinessAnswer.veryHairyShort),
            ),
            const SizedBox(height: 12),
          ],

          IdentifyAnswerCard(
            title: '不明 / スキップ',
            subtitle: '毛の状態が分からない場合',
            selected: _selectedAnswer == PeduncleHairinessAnswer.unknown,
            onTap: () => _selectAnswer(PeduncleHairinessAnswer.unknown),
          ),
        ],
      ),
    );
  }
}
