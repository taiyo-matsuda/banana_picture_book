import 'package:shadcn_flutter/shadcn_flutter.dart';

class IdentifyBottomAction extends StatelessWidget {
  const IdentifyBottomAction({
    super.key,
    required this.enabled,
    required this.onPressed,
    this.label = '次へ',
  });

  final bool enabled;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          onPressed: enabled ? onPressed : null,
          child: Text(label),
        ),
      ),
    );
  }
}
