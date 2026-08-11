class SapColour {
  const SapColour({required this.value});

  final String value;

  factory SapColour.fromMap(Map<String, dynamic> map) {
    return SapColour(value: map['sap_colour'] as String);
  }
}
