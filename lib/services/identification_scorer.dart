import '../models/identification_answer.dart';
import '../models/identification_candidate.dart';
import '../models/identification_result.dart';
import 'identification_session.dart';

class IdentificationScorer {
  List<IdentificationResult> score({
    required IdentificationSession session,
    required List<IdentificationCandidate> candidates,
  }) {
    final results = candidates.map((candidate) {
      var score = 0;
      var answeredCount = 0;

      if (session.q1Height != null &&
          session.q1Height != HeightAnswer.unknown) {
        answeredCount++;

        if (_matchesHeight(
          session.q1Height!,
          candidate.heightMin,
          candidate.heightMax,
        )) {
          score += 2;
        }
      }

      if (session.q2PeelColour != null &&
          session.q2PeelColour != PeelColourAnswer.unknown) {
        answeredCount++;

        if (_matchesPeelColour(session.q2PeelColour!, candidate.peelColour)) {
          score += 2;
        }
      }

      if (session.q3PulpColour != null &&
          session.q3PulpColour != PulpColourAnswer.unknown) {
        answeredCount++;

        if (_matchesPulpColour(session.q3PulpColour!, candidate.pulpColour)) {
          score += 2;
        }
      }

      if (session.q4FruitApex != null &&
          session.q4FruitApex != FruitApexAnswer.unknown) {
        answeredCount++;

        if (_matchesFruitApex(session.q4FruitApex!, candidate.fruitApex)) {
          score += 2;
        }
      }

      if (session.q5FruitLength != null &&
          session.q5FruitLength != FruitLengthAnswer.unknown) {
        answeredCount++;

        if (_matchesFruitLength(
          session.q5FruitLength!,
          candidate.fruitLengthMin,
          candidate.fruitLengthMax,
        )) {
          score += 2;
        }
      }

      if (session.q6FruitTransverseSection != null &&
          session.q6FruitTransverseSection !=
              FruitTransverseSectionAnswer.unknown) {
        answeredCount++;

        if (_matchesTransverseSection(
          session.q6FruitTransverseSection!,
          candidate.fruitTransverseSection,
        )) {
          score += 2;
        }
      }

      if (session.q7PeduncleHairiness != null &&
          session.q7PeduncleHairiness != PeduncleHairinessAnswer.unknown) {
        answeredCount++;

        if (_matchesPeduncleHairiness(
          session.q7PeduncleHairiness!,
          candidate.peduncleHairiness,
        )) {
          score += 2;
        }
      }

      if (session.q8SapColour != null &&
          session.q8SapColour != SapColourAnswer.unknown) {
        answeredCount++;

        if (_matchesSapColour(session.q8SapColour!, candidate.sapColour)) {
          score += 2;
        }
      }

      return IdentificationResult(
        candidate: candidate,
        score: score,
        maxScore: answeredCount * 2,
      );
    }).toList();

    results.sort((a, b) {
      final rateCompare = b.matchRate.compareTo(a.matchRate);

      if (rateCompare != 0) {
        return rateCompare;
      }

      return b.score.compareTo(a.score);
    });

    return results;
  }

  bool _matchesHeight(HeightAnswer answer, double? min, double? max) {
    if (min == null && max == null) {
      return false;
    }

    switch (answer) {
      case HeightAnswer.low:
        return min != null && min <= 2.0;

      case HeightAnswer.mid:
        return min != null && max != null && min <= 2.9 && max >= 2.1;

      case HeightAnswer.high:
        return max != null && max >= 3.0;

      case HeightAnswer.unknown:
        return false;
    }
  }

  bool _matchesPeelColour(PeelColourAnswer answer, String? value) {
    switch (answer) {
      case PeelColourAnswer.yellow:
        return value == 'yellow' ||
            value == 'bright_yellow' ||
            value == '黄色' ||
            value == '鮮黄色';

      case PeelColourAnswer.orange:
        return value == 'orange' || value == 'オレンジ色';

      case PeelColourAnswer.blue:
        return value == 'bluish';

      case PeelColourAnswer.unknown:
        return false;
    }
  }

  bool _matchesPulpColour(PulpColourAnswer answer, String? value) {
    switch (answer) {
      case PulpColourAnswer.ivory:
        return value == 'アイボリー';

      case PulpColourAnswer.cream:
        return value == 'クリーム色';

      case PulpColourAnswer.white:
        return value == '白色';

      case PulpColourAnswer.yellow:
        return value == '黄色';

      case PulpColourAnswer.unknown:
        return false;
    }
  }

  bool _matchesFruitApex(FruitApexAnswer answer, String? value) {
    switch (answer) {
      case FruitApexAnswer.pointed:
        return value == '尖っている';

      case FruitApexAnswer.bottleNeck:
        return value == '瓶の首状';

      case FruitApexAnswer.longPointed:
        return value == '細長く尖っている';

      case FruitApexAnswer.blunt:
        return value == '鈍い先端';

      case FruitApexAnswer.unknown:
        return false;
    }
  }

  bool _matchesFruitLength(FruitLengthAnswer answer, double? min, double? max) {
    switch (answer) {
      case FruitLengthAnswer.short:
        return max != null && max <= 15;

      case FruitLengthAnswer.medium:
        return min != null && max != null && min <= 20 && max >= 16;

      case FruitLengthAnswer.long:
        return min != null && min >= 21;

      case FruitLengthAnswer.unknown:
        return false;
    }
  }

  bool _matchesTransverseSection(
    FruitTransverseSectionAnswer answer,
    String? value,
  ) {
    switch (answer) {
      case FruitTransverseSectionAnswer.round:
        return value == '丸い';

      case FruitTransverseSectionAnswer.pronouncedRidges:
        return value == '明瞭な稜';

      case FruitTransverseSectionAnswer.slightlyRidged:
        return value == 'やや稜状';

      case FruitTransverseSectionAnswer.faintRidges:
        return value == 'わずかに稜がある';

      case FruitTransverseSectionAnswer.unknown:
        return false;
    }
  }

  bool _matchesPeduncleHairiness(
    PeduncleHairinessAnswer answer,
    String? value,
  ) {
    switch (answer) {
      case PeduncleHairinessAnswer.hairless:
        return value == '無毛';

      case PeduncleHairinessAnswer.veryHairyLong:
        return value == '非常に毛深い、長い毛（2mm超）';

      case PeduncleHairinessAnswer.slightlyHairy:
        return value == 'やや毛深い';

      case PeduncleHairinessAnswer.veryHairyShort:
        return value == '非常に毛深い、短い毛（ビロードのような手触り）';

      case PeduncleHairinessAnswer.unknown:
        return false;
    }
  }

  bool _matchesSapColour(SapColourAnswer answer, String? value) {
    switch (answer) {
      case SapColourAnswer.milkyWhite:
        return value == '乳白色';

      case SapColourAnswer.watery:
        return value == '水様';

      case SapColourAnswer.unknown:
        return false;
    }
  }
}
