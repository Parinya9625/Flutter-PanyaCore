extension PercentNumberExtension on num {
  double percentOf({num min = 0, num max = 1}) {
    assert(min < max);
    return (this / 100).normalizePercentOf(min: min, max: max);
  }

  double normalizePercentOf({num min = 0, num max = 1}) {
    assert(min < max);
    return min + (this * (max - min)).toDouble();
  }
}