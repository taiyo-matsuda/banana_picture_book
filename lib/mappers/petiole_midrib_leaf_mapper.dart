import '../models/petiole_midrib_leaf.dart';

class PetioleMidribLeafMapper {
  static PetioleMidribLeaf fromMap(Map<String, dynamic> map) {
    return PetioleMidribLeaf(
      id: map['id'] as int,
      varietyId: map['variety_id'] as int,
      petioleCanalLeafIii: map['petiole_canal_leaf_iii'] as String?,
      midribDorsalSurfaceColour: map['midrib_dorsal_surface_colour'] as String?,
      cigarLeafDorsalSurfaceColour:
          map['cigar_leaf_dorsal_surface_colour'] as String?,
      waterSuckersLeafBlotches: map['water_suckers_leaf_blotches'] as String?,
    );
  }
}
