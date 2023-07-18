import 'package:flutter/material.dart';

/// Border decoration that can set offset from border start position
class OffsetBorder extends Border {
  /// offset from widget border position
  final double offset;

  /// Color of border
  final Color color;

  /// Gradient color of border
  ///
  /// if [gradient] is not null, [color] will be ignore
  final Gradient? gradient;

  /// Border width
  final double width;

  /// Create border with offset from border start position
  ///
  /// This help to create gap between widget and border without 
  /// create multiple decoration
  ///
  /// ```dart
  /// Container(
  ///   decoration: BoxDecoration(
  ///     color: Colors.grey,
  ///     border: OffsetBorder(
  ///       offset: 5,
  ///       width: 3,
  ///     ),
  ///   ),
  /// );
  /// ```
  const OffsetBorder({
    this.offset = 0,
    this.color = Colors.black,
    this.gradient,
    this.width = 0,
  });

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    switch (shape) {
      case BoxShape.rectangle:
        switch (borderRadius) {
          case null:
            _drawRect(canvas, rect);
          default:
            _drawRRect(canvas, rect, borderRadius);
        }
      case BoxShape.circle:
        _drawCircle(canvas, rect);
        break;
    }
  }

  void _drawRect(Canvas canvas, Rect rect) {
    Paint paint = _getPaint(rect);

    canvas.drawRect(rect.deflate(-offset), paint);
  }

  void _drawRRect(Canvas canvas, Rect rect, BorderRadius? borderRadius) {
    Paint paint = _getPaint(rect);
    var rrect =
        (borderRadius ?? BorderRadius.zero).toRRect(rect).deflate(-offset);

    canvas.drawRRect(rrect, paint);
  }

  void _drawCircle(Canvas canvas, Rect rect) {
    Paint paint = _getPaint(rect);

    canvas.drawCircle(
      rect.center,
      (rect.shortestSide / 2) + offset,
      paint,
    );
  }

  Paint _getPaint(Rect rect) {
    if (width <= 0) {
      return Paint()..color = Colors.transparent;
    }
    switch (gradient) {
      case null:
        return Paint()
          ..strokeWidth = width
          ..color = color
          ..style = PaintingStyle.stroke;
      default:
        return Paint()
          ..strokeWidth = width
          ..shader = gradient!.createShader(rect)
          ..style = PaintingStyle.stroke;
    }
  }
}
