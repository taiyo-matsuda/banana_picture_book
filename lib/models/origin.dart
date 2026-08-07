import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

class Origin {
  final int id;
  final int varietyId;
  final String? origin;
  final String? province;
  final String? exactLocation;
  final String? collectingSource;
  final String? localVernacularName;
  final String? accessionCode;
  final Bool useForDessert;
  final Bool useForCooking;

  const Origin({
    required this.id,
    required this.varietyId,
    this.origin,
    this.province,
    this.exactLocation,
    this.collectingSource,
    this.localVernacularName,
    this.accessionCode,
    required this.useForDessert,
    required this.useForCooking,
  });
}
