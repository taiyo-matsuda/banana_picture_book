import 'package:shadcn_flutter/shadcn_flutter.dart';

class DetailRow extends StatelessWidget {
  const DetailRow({super.key, required this.label, required this.value});
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.mutedForeground,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 5,
            child: Text(
              value!,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
