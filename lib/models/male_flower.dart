class MaleFlower {
  final int id;
  final int varietyId;
  final String? compoundTepalBasicColour;
  final String? compoundTepalPigmentation;
  final String? compoundTepalLobeColour;
  final String? freeTepalAppearance;
  final String? styleShape;
  final String? stigmaColour;
  final String? ovaryBasicColour;
  final String? ovaryPigmentation;

  const MaleFlower({
    required this.id,
    required this.varietyId,
    this.compoundTepalBasicColour,
    this.compoundTepalPigmentation,
    this.compoundTepalLobeColour,
    this.freeTepalAppearance,
    this.styleShape,
    this.stigmaColour,
    this.ovaryBasicColour,
    this.ovaryPigmentation,
  });
}
