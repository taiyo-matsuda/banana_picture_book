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
      int score = 0;
      int answeredCount = 0;

      // Q1 高さ
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

      // Q2 果皮色
      if (session.q2PeelColour != null &&
          session.q2PeelColour != PeelColourAnswer.unknown) {
        answeredCount++;

        if (_matchesPeelColour(session.q2PeelColour!, candidate.peelColour)) {
          score += 2;
        }
      }

      // Q3 果肉色
      if (session.q3PulpColour != null &&
          session.q3PulpColour != PulpColourAnswer.unknown) {
        answeredCount++;

        if (_matchesPulpColour(session.q3PulpColour!, candidate.pulpColour)) {
          score += 2;
        }
      }

      // Q4 果実先端
      if (session.q4FruitApex != null &&
          session.q4FruitApex != FruitApexAnswer.unknown) {
        answeredCount++;

        if (_matchesFruitApex(session.q4FruitApex!, candidate.fruitApex)) {
          score += 2;
        }
      }

      // Q5 果実長
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

      // Q6 横断面
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

      // Q7 果軸の毛
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

      // Q8 樹液
      if (session.q8SapColour != null &&
          session.q8SapColour != SapColourAnswer.unknown) {
        answeredCount++;

        if (_matchesSapColour(session.q8SapColour!, candidate.sapColour)) {
          score += 2;
        }
      }

      final maxScore = answeredCount * 2;

      return IdentificationResult(
        candidate: candidate,
        score: score,
        maxScore: maxScore,
      );
    }).toList();

    results.sort((a, b) => b.score.compareTo(a.score));

    return results;
  }

  bool _matchesHeight(HeightAnswer answer, double? min, double? max) {
    if (answer == HeightAnswer.low) {
      return max != null && max <= 2.0;
    }

    if (answer == HeightAnswer.mid) {
      return min != null && max != null && min <= 2.9 && max >= 2.1;
    }

    if (answer == HeightAnswer.high) {
      return min != null && min >= 3.0;
    }

    return false;
  }

  bool _matchesPeelColour(PeelColourAnswer answer, String? value) {
    if (value == null) {
      return false;
    }

    switch (answer) {
      case PeelColourAnswer.yellow:
        return value == 'yellow' || value == 'bright_yellow';

      case PeelColourAnswer.orange:
        return value == 'orange';

      case PeelColourAnswer.blue:
        return value == 'bluish';

      case PeelColourAnswer.unknown:
        return false;
    }
  }

  bool _matchesPulpColour(PulpColourAnswer answer, String? value) {
    if (value == null) {
      return false;
    }

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
    if (value == null) {
      return false;
    }

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
    if (answer == FruitLengthAnswer.short) {
      return max != null && max <= 15;
    }

    if (answer == FruitLengthAnswer.medium) {
      return min != null && max != null && min <= 20 && max >= 16;
    }

    if (answer == FruitLengthAnswer.long) {
      return min != null && min >= 21;
    }

    return false;
  }

  bool _matchesTransverseSection(
    FruitTransverseSectionAnswer answer,
    String? value,
  ) {
    if (value == null) {
      return false;
    }

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
    if (value == null) {
      return false;
    }

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
    if (value == null) {
      return false;
    }

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
