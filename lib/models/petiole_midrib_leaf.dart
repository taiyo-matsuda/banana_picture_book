class PetioleMidribLeaf {
  final int id;
  final int varietyId;
  final String? petioleCanalLeafIii;
  final String? midribDorsalSurfaceColour;
  final String? cigarLeafDorsalSurfaceColour;
  final String? waterSuckersLeafBlotches;

  const PetioleMidribLeaf({
    required this.id,
    required this.varietyId,
    this.petioleCanalLeafIii,
    this.midribDorsalSurfaceColour,
    this.cigarLeafDorsalSurfaceColour,
    this.waterSuckersLeafBlotches,
  });
}
