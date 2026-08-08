class PlantTrait {
  final int id;
  final int varietyId;
  final String? leafHabit;
  final double? pseudostemHeightMin;
  final double? pseudostemHeightMax;
  final String? pseudostemColour;
  final String? pseudostemAppearance;
  final String? underlyingPseudostemPigmentation;
  final String? sapColour;
  final int? suckersMin;
  final int? suckersMax;
  final String? suckerDevelopment;
  final String? suckerPosition;
  final String? petioleBaseBlotches;
  final String? blotchesColour;
  final String? pseudostemAspect;

  const PlantTrait({
    required this.id,
    required this.varietyId,
    this.leafHabit,
    this.pseudostemHeightMin,
    this.pseudostemHeightMax,
    this.pseudostemColour,
    this.pseudostemAppearance,
    this.underlyingPseudostemPigmentation,
    this.sapColour,
    this.suckersMin,
    this.suckersMax,
    this.suckerDevelopment,
    this.suckerPosition,
    this.petioleBaseBlotches,
    this.blotchesColour,
    this.pseudostemAspect,
  });
}
