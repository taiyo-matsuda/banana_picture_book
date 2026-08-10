import '../models/identification_answer.dart';

class IdentificationSession {
  HeightAnswer? q1Height;
  PeelColourAnswer? q2PeelColour;

  void reset() {
    q1Height = null;
    q2PeelColour = null;
  }
}
