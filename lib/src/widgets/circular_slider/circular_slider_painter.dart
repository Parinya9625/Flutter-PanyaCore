import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import 'circular_slider_style.dart';

typedef CircularSliderData = ({
  double shortestSize,
  double maxSize,
  double radius,
  double progress,
});

class CircularSliderPainter extends CustomPainter {
  final double value;
  final double min;
  final double max;
  final bool draggable;
  final CircularSliderStyle style;

  Path _basePath = Path();
  Path _valuePath = Path();
  Path _blockPath = Path();

  CircularSliderPainter({
    required this.value,
    this.min = 0,
    this.max = 1,
    this.draggable = false,
    this.style = const CircularSliderStyle(),
  })  : assert(min <= max),
        assert(
          value >= min && value <= max,
          "Value $value is not between minimum $min and maximum $max",
        );

  CircularSliderData circularSliderData(Size size) {
    var shortestSize = math.min(size.width, size.height);
    var maxSize = shortestSize * style.scale;
    var radius = maxSize / 2;
    var progress = value.normalizeFrom(min: min, max: max);

    return (
      shortestSize: shortestSize,
      maxSize: maxSize,
      radius: radius,
      progress: progress.toDouble(),
    );
  }

  void drawBaseSlider(Canvas canvas, Size size) {
    var sliderData = circularSliderData(size);
    var paint = style.basePaint;

    _basePath = Path();
    _basePath.addArc(
      Rect.fromCenter(
        center: size.center(Offset.zero),
        width: sliderData.maxSize,
        height: sliderData.maxSize,
      ),
      style.startAngle,
      style.sweepAngle,
    );

    canvas.drawPath(_basePath, paint);
  }

  void drawValueSlider(Canvas canvas, Size size) {
    var sliderData = circularSliderData(size);
    var paint = style.valuePaint;

    _valuePath = Path();
    _valuePath.addArc(
      Rect.fromCenter(
        center: size.center(Offset.zero),
        width: sliderData.maxSize,
        height: sliderData.maxSize,
      ),
      style.startAngle,
      style.sweepAngle * sliderData.progress,
    );

    canvas.drawPath(_valuePath, paint);
  }

  void drawThumbSlider(Canvas canvas, Size size) {
    var sliderData = circularSliderData(size);
    var valuePaint = style.valuePaint;
    var thumbPaint = style.thumbPaint;

    // Thumb background
    canvas.drawCircle(
      size.center(
        Offset(
          sliderData.radius * math.sin(style.sweepAngle * sliderData.progress),
          -sliderData.radius * math.cos(style.sweepAngle * sliderData.progress),
        ),
      ),
      0,
      valuePaint,
    );
    // Thumb foreground
    canvas.drawCircle(
      size.center(
        Offset(
          sliderData.radius * math.sin(style.sweepAngle * sliderData.progress),
          -sliderData.radius * math.cos(style.sweepAngle * sliderData.progress),
        ),
      ),
      thumbPaint.strokeWidth,
      thumbPaint,
    );
  }

  void createBlockArea(Canvas canvas, Size size) {
    var shortestSize = math.min(size.width, size.height);
    var blockScale = style.scale - (style.valuePaint.strokeWidth / 200);
    var maxSize = shortestSize * blockScale;

    _blockPath = Path();
    _blockPath.addArc(
      Rect.fromCenter(
        center: size.center(Offset.zero),
        width: maxSize,
        height: maxSize,
      ),
      style.startAngle,
      style.sweepAngle,
    );
  }

  @override
  bool? hitTest(Offset position) {
    var inValuePath =
        _basePath.contains(position) || _valuePath.contains(position);
    var inBlockPath = _blockPath.contains(position) && style.mode.isCompact;

    return draggable && inValuePath && !inBlockPath;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawBaseSlider(canvas, size);
    drawValueSlider(canvas, size);
    drawThumbSlider(canvas, size);
    createBlockArea(canvas, size);
  }

  @override
  bool shouldRepaint(CircularSliderPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.min != min ||
        oldDelegate.max != max ||
        oldDelegate.style != style;
  }
}
