extension NormalizeNumberExtension on num {
  double normalizeFrom({double min = 0, double max = 1}) {
    assert(min < max);
    assert(this >= min && this <= max);

    return (this - min) / (max - min);
  }

  double denormalizeTo({double min = 0, double max = 1}) {
    assert(min < max);
    assert(this >= 0 && this <= 1);

    return (this * (max - min)) + min;
  }
}
