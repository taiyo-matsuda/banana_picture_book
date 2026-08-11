class PeduncleHairiness {
  const PeduncleHairiness({required this.value});

  final String value;

  factory PeduncleHairiness.fromMap(Map<String, dynamic> map) {
    return PeduncleHairiness(value: map['peduncle_hairiness'] as String);
  }
}
