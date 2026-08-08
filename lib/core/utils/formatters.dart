String? range(double? min, double? max, {String suffix = ''}) {
  if (min == null && max == null) {
    return null;
  }

  if (min != null && max != null) {
    return '${_formatNumber(min)}–${_formatNumber(max)}$suffix';
  }

  if (min != null) {
    return '≥${_formatNumber(min)}$suffix';
  }

  return '≤${_formatNumber(max!)}$suffix';
}

String? intRange(int? min, int? max) {
  if (min == null && max == null) {
    return null;
  }

  if (min != null && max != null) {
    return '$min–$max';
  }

  if (min != null) {
    return '≥$min';
  }

  return '≤$max';
}

String _formatNumber(double value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }

  return value.toString();
}
