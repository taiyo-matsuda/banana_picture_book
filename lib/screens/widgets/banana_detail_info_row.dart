import 'package:shadcn_flutter/shadcn_flutter.dart';

class BananaDetailInfoRow extends StatelessWidget {
  const BananaDetailInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.mutedForeground,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
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
