import 'identification_candidate.dart';

class IdentificationResult {
  const IdentificationResult({
    required this.candidate,
    required this.score,
    required this.maxScore,
  });

  final IdentificationCandidate candidate;
  final int score;
  final int maxScore;

  double get matchRate {
    if (maxScore == 0) {
      return 0;
    }

    return score / maxScore * 100;
  }
}
