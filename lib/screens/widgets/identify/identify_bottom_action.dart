import 'package:shadcn_flutter/shadcn_flutter.dart';

class IdentifyBottomAction extends StatelessWidget {
  const IdentifyBottomAction({
    super.key,
    required this.enabled,
    required this.onPressed,
    this.onBack,
  });

  final bool enabled;
  final VoidCallback onPressed;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final hasBackButton = onBack != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          if (hasBackButton) ...[
            Expanded(
              child: Button(
                style: ButtonStyle(variance: ButtonVariance.outline),
                onPressed: onBack,
                child: const Text('戻る'),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Button(
              style: ButtonStyle(variance: ButtonVariance.primary),
              onPressed: enabled ? onPressed : null,
              child: const Text('次へ'),
            ),
          ),
        ],
      ),
    );
  }
}
