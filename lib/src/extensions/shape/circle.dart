import 'dart:math' as math;
import 'package:flutter/material.dart';

extension CircleOffsetExtension on Offset {
  double findAngle(Offset point) {
    return math.atan2(point.dy - dy, point.dx - dx);
  }
}

extension CircleNunberExtension on num {
  double toDegree([double offset = 0]) {
    return (this * (180 / math.pi)) + offset;
  }

  double to360Degree([double offset = 0]) {
    return toDegree(offset) % 360;
  }

  double toAngle([double offset = 0]) {
    return (this * (math.pi / 180)) + offset;
  }
}
