class Variety {
  final int id;
  final String musalogueName;
  final String canonicalName;
  final String? thumbnailImageUrl;

  const Variety({
    required this.id,
    required this.musalogueName,
    required this.canonicalName,
    this.thumbnailImageUrl,
  });
}
