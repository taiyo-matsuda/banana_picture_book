class Fruit {
  final int id;
  final int varietyId;
  final String? fruitPosition;
  final int? fruitsMin;
  final int? fruitsMax;
  final double? fruitLengthMin;
  final double? fruitLengthMax;
  final String? fruitShape;
  final String? fruitTransverseSection;
  final String? fruitApex;
  final String? flowerRelictsAtApex;
  final double? fruitPedicelLengthMin;
  final double? fruitPedicelLengthMax;
  final String? maturePeelColour;
  final String? pulpPresence;
  final String? pulpColourAtMaturity;
  final int? seedsWithPollenSourceMin;
  final int? seedsWithPollenSourceMax;
  final String? seedShape;

  const Fruit({
    required this.id,
    required this.varietyId,
    this.fruitPosition,
    this.fruitsMin,
    this.fruitsMax,
    this.fruitLengthMin,
    this.fruitLengthMax,
    this.fruitShape,
    this.fruitTransverseSection,
    this.fruitApex,
    this.flowerRelictsAtApex,
    this.fruitPedicelLengthMin,
    this.fruitPedicelLengthMax,
    this.maturePeelColour,
    this.pulpPresence,
    this.pulpColourAtMaturity,
    this.seedsWithPollenSourceMin,
    this.seedsWithPollenSourceMax,
    this.seedShape,
  });
}
