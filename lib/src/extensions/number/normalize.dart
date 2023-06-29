extension NormalizeNumberExtension on num {
  double normalizeFrom({double min = 0, double max = 1}) {
    assert(min < max);
    return (this - min) / (max - min);
  }

  double denormalizeTo({double min = 0, double max = 1}) {
    assert(min < max);
    return (this * (max - min)) + min;
  }
}
