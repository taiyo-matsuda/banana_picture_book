class InflorescenceMaleBud {
  final int id;
  final int varietyId;
  final double? peduncleLengthMin;
  final double? peduncleLengthMax;
  final String? peduncleHairiness;
  final String? bunchPosition;
  final String? rachisType;
  final String? rachisPosition;
  final String? rachisAppearance;
  final String? maleBudType;
  final String? maleBudShape;
  final String? bractApexShape;
  final String? bractImbrication;
  final String? bractExternalColour;
  final String? bractInternalColour;
  final String? bractScarsOnRachis;
  final String? bractBaseColourFading;
  final String? bractBehaviourBeforeFalling;
  final String? bractWax;

  const InflorescenceMaleBud({
    required this.id,
    required this.varietyId,
    this.peduncleLengthMin,
    this.peduncleLengthMax,
    this.peduncleHairiness,
    this.bunchPosition,
    this.rachisType,
    this.rachisPosition,
    this.rachisAppearance,
    this.maleBudType,
    this.maleBudShape,
    this.bractApexShape,
    this.bractImbrication,
    this.bractExternalColour,
    this.bractInternalColour,
    this.bractScarsOnRachis,
    this.bractBaseColourFading,
    this.bractBehaviourBeforeFalling,
    this.bractWax,
  });
}
