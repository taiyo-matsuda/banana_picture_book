class IdentificationCandidate {
  const IdentificationCandidate({
    required this.varietyId,
    required this.canonicalName,
    this.musalogueName,
    this.heightMin,
    this.heightMax,
    this.peelColour,
    this.pulpColour,
    this.fruitApex,
    this.fruitLengthMin,
    this.fruitLengthMax,
    this.fruitTransverseSection,
    this.peduncleHairiness,
    this.sapColour,
  });

  final int varietyId;
  final String canonicalName;
  final String? musalogueName;

  final double? heightMin;
  final double? heightMax;

  final String? peelColour;
  final String? pulpColour;
  final String? fruitApex;

  final double? fruitLengthMin;
  final double? fruitLengthMax;

  final String? fruitTransverseSection;
  final String? peduncleHairiness;
  final String? sapColour;
}
