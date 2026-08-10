import 'package:shadcn_flutter/shadcn_flutter.dart';

class IdentifyAnswerCard extends StatelessWidget {
  const IdentifyAnswerCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: selected
                  ? const Color(0xFF18181B)
                  : const Color(0xFFE4E4E7),
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF71717A),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? const Color(0xFF18181B)
                        : const Color(0xFFA1A1AA),
                    width: 2,
                  ),
                ),
                child: selected
                    ? const Center(
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color(0xFF18181B),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
