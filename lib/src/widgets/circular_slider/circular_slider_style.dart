import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircularSliderStyle {
  final double scale;
  final double startAngle;
  final double sweepAngle;
  final Duration animationDuration;
  final Curve animationCurve;
  final CircularSliderDragMode mode;

  final Paint? _basePaint;
  final Paint? _valuePaint;
  final Paint? _thumbPaint;

  Paint get basePaint => _basePaint ?? _defaultBasePaint();
  Paint get valuePaint => _valuePaint ?? _defaultValuePaint();
  Paint get thumbPaint => _thumbPaint ?? _defaultThumbPaint();

  Paint _defaultBasePaint() {
    return Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
  }

  Paint _defaultValuePaint() {
    return Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;
  }

  Paint _defaultThumbPaint() {
    return Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
  }

  const CircularSliderStyle({
    this.scale = 0.8,
    this.startAngle = 3 * math.pi / 2,
    this.sweepAngle = 2 * math.pi,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.mode = CircularSliderDragMode.full,
    Paint? basePaint,
    Paint? valuePaint,
    Paint? thumbPaint,
  })  : _basePaint = basePaint,
        _valuePaint = valuePaint,
        _thumbPaint = thumbPaint;
}

enum CircularSliderDragMode {
  /// Only slider value can drag
  compact,

  /// Everywhere inside circular silder can be drag
  full;
}

extension CircularSliderDragModeX on CircularSliderDragMode {
  bool get isCompact => this == CircularSliderDragMode.compact;
  bool get isFull => this == CircularSliderDragMode.full;
}
