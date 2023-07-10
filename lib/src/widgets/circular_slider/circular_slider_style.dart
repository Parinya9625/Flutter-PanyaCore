import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Customize style for [CircularSlider]
class CircularSliderStyle {
  /// Scale slider size, by default it scale to `0.8` that mean widget will be
  /// display smaller in full container box and have empty space around it and
  /// you can change to `1.0` to make slider scale full size to fit container
  final double scale;

  /// Start position of slider that can be dragged, value can be between 0 to 2π
  final double startAngle;

  /// Sweep angle base on [startAngle] that can show how much user can dragged
  /// to the end of slider, value can be 0 to 2π
  final double sweepAngle;

  /// Duration between old slider value to new slider value
  final Duration animationDuration;

  /// Animation curve for slider
  final Curve animationCurve;

  /// Drag behavior that user can interact with slider
  final CircularSliderDragMode mode;

  /// Base paint that show background of slider value
  final Paint? _basePaint;

  /// Value paint that show current value of slider
  final Paint? _valuePaint;
  
  /// Thumb paint that show head of slider value
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

  /// Customize style for [CircularSlider]
  ///
  /// ```dart
  /// CircularSlider(
  ///   style: CircularSliderStyle(
  ///     // Customize your style here
  ///     scale: 0.8,
  ///     startAngle: 3 * math.pi / 2,
  ///     sweepAngle: 2 * math.pi / 2,
  ///   ),
  /// );
  
  /// ```
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
