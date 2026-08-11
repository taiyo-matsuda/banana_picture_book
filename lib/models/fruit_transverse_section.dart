class FruitTransverseSection {
  const FruitTransverseSection({required this.value});

  final String value;

  factory FruitTransverseSection.fromMap(Map<String, dynamic> map) {
    return FruitTransverseSection(
      value: map['fruit_transverse_section'] as String,
    );
  }
}
