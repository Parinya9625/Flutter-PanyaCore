import 'dart:math' as math;
import 'package:flutter/widgets.dart';

extension CircleOffsetExtension on Offset {
  /// Calculate angle of the circle, `value` is center position of circle and
  /// [point] is destination position
  ///
  /// ```dart
  /// const Offset(0, 0).findAngle(const Offset(0, 1)); // 1.5708 radians
  /// ```
  double findAngle(Offset point) {
    return math.atan2(point.dy - dy, point.dx - dx);
  }
}

extension CircleNumberExtension on num {
  /// Convert angle (radians) to degree
  ///
  /// ```dart
  /// (1.5708).toDegree(); // 90.00 degree
  /// ```
  double toDegree([double offset = 0]) {
    return (this * (180 / math.pi)) + offset;
  }

  /// Convert angle (radians) to degree and mod (%) result with 360
  ///
  /// ```dart
  /// (1.5708).toDegree(); // 90.00 degree
  /// ```
  double to360Degree([double offset = 0]) {
    return toDegree(offset) % 360;
  }

  /// Convert degree to angle (radians)
  ///
  /// ```dart
  /// 90.toDegree(); // 1.5708 radians
  /// ```
  double toAngle([double offset = 0]) {
    return (this * (math.pi / 180)) + offset;
  }
}
