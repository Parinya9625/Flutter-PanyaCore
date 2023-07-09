extension NormalizeNumberExtension on num {
  /// Normalize number from range of [min] and [max] into 0 to 1
  ///
  /// ```dart
  /// 10.normalizeFrom(min: 0, max: 100); // 0.1
  /// ```
  double normalizeFrom({double min = 0, double max = 1}) {
    assert(min < max);
    assert(this >= min && this <= max);

    return (this - min) / (max - min);
  }

  /// Denormalize number from 0 to 1 into range of [min] and [max]
  ///
  /// ```dart
  /// (0.1).denormalizeTo(min: 0, max: 100); // 10
  /// ```
  double denormalizeTo({double min = 0, double max = 1}) {
    assert(min < max);
    assert(this >= 0 && this <= 1);

    return (this * (max - min)) + min;
  }
}
