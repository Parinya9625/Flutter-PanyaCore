/// Provides convenient way to generate list of number
class NumberRange {
  NumberRange._();

  /// Generate range of number that start from [start] and will increase number
  /// by [step] and will stop generate when number is greater than [stop]
  ///
  /// This function have similar behavior like range() in python
  ///
  /// ```dart
  /// NumberRange.create(start: 2, stop: 7); // [2, 3, 4, 5, 6]
  /// ```
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

  /// Generate list of number that start from [start] and will increase number
  /// by [step] and will genarate until length of this list is equal to [count]
  ///
  /// ```dart
  /// NumberRange.make(5); // [0, 1, 2, 3, 4]
  /// ```
  static List<num> make(num count, {num start = 0, num step = 1}) {
    return create(
      start: start,
      stop: start + count * step,
      step: step,
    );
  }
}
