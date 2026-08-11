import '../models/identification_answer.dart';

class IdentificationSession {
  HeightAnswer? q1Height;
  PeelColourAnswer? q2PeelColour;
  PulpColourAnswer? q3PulpColour;

  void reset() {
    q1Height = null;
    q2PeelColour = null;
    q3PulpColour = null;
  }
}
