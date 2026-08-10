import 'package:shadcn_flutter/shadcn_flutter.dart';

class IdentifyProgressHeader extends StatelessWidget {
  const IdentifyProgressHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$currentStep / $totalSteps',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF71717A),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFE4E4E7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF18181B),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
