class NumberRange {
  NumberRange._();

  /// same function as range() in python
  static List<num> create({
    num start = 0,
    required num stop,
    num step = 1,
  }) {
    if (!step.isNegative && stop < start) return [];
    if (step.isNegative && start < stop) return [];

    return List.generate(
      ((stop - start) / step).ceil(),
      (index) => (step * index) + start,
    );
  }

  static List<num> make(num count, {num start = 0, num step = 1}) {
    return create(
      start: start,
      stop: start + count * step,
      step: step,
    );
  }
}
