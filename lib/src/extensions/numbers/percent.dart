extension PercentNumberExtension on num {
  /// Calculate the percentage of the number with in range of [min] and [max]
  double percentOf({num min = 0, num max = 1}) {
    assert(min < max);
    return (this / 100).normalizePercentOf(min: min, max: max);
  }

  /// Calculate the percentage of the number with in range of [min] and [max]
  /// but number must only in range of 0 to 1
  double normalizePercentOf({num min = 0, num max = 1}) {
    assert(min < max);
    return min + (this * (max - min)).toDouble();
  }
}
