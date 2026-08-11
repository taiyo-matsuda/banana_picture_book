class FruitLength {
  const FruitLength({required this.min, required this.max});

  final double? min;
  final double? max;

  factory FruitLength.fromMap(Map<String, dynamic> map) {
    return FruitLength(
      min: (map['fruit_length_min'] as num?)?.toDouble(),
      max: (map['fruit_length_max'] as num?)?.toDouble(),
    );
  }
}
