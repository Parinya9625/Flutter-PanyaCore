import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import 'circular_slider_style.dart';
import 'circular_slider_painter.dart';

export 'circular_slider_style.dart';

/// Slider widget that display in circular shape 
class CircularSlider extends StatefulWidget {
  /// Current value of slider
  final double value;
  
  /// Minimum number in slider, must be less than [max]
  final double min;

  /// Maximum number in slider, must be more than [min]
  final double max;

  /// Enable dragging for slider
  final bool draggable;

  /// Apply style to [CircularSlider] like change start position with 
  /// [CircularSliderStyle.startAngle] or change slider scale size with
  /// [CircularSliderStyle.scale] etc.
  final CircularSliderStyle style;

  /// Callback that call everytime [CircularSlider] update value
  final Function(double value)? onChanged;

  /// Create slider widget that display in circular shape and when state is
  /// chnaged, the widget will call [onChanged] callback and sent current vaule
  /// back to update widget
  ///
  /// ```dart
  /// CircularSlider(
  ///   vaule: 50,
  ///   min: 0,
  ///   max: 100,
  ///   onChanged: (newValue) {
  ///     setState(() {
  ///       // Update slider value here
  ///     });  
  ///   },
  /// );
  /// ```
  const CircularSlider({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 1,
    this.draggable = true,
    this.style = const CircularSliderStyle(),
    this.onChanged,
  })  : assert(min <= max),
        assert(
          value >= min && value <= max,
          "Value $value is not between minimum $min and maximum $max",
        );

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider>
    with SingleTickerProviderStateMixin {
  bool isDrag = false;
  late AnimationController animationController;
  late Tween<double> tweenValue;
  late Animation<double> animationValue;

  void updateSlider(BoxConstraints constraints, Offset position) {
    var box = Size(constraints.maxWidth, constraints.maxHeight);
    var center = box.center(Offset.zero);

    var angle = center.findAngle(position);
    var degreeOffset = (360 - widget.style.startAngle.toDegree());
    var progressOffset = (360 - widget.style.sweepAngle.toDegree());

    var degree = angle.to360Degree(degreeOffset);
    var progress = (degree / (360 - progressOffset));

    var oldProgress =
        widget.value.normalizeFrom(min: widget.min, max: widget.max);
    var newValue = math.min(
      progress.normalizePercentOf(min: widget.min, max: widget.max),
      widget.max,
    );

    if (isDrag && oldProgress < 0.1 && progress > 0.5) {
      newValue = widget.min;
    } else if (isDrag && oldProgress > 0.9 && progress < 0.5) {
      newValue = widget.max;
    }

    widget.onChanged?.call(newValue);
  }

  void setupAnimationValue() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.style.animationDuration,
    )..forward();

    tweenValue = Tween<double>(begin: widget.max, end: widget.value);
    animationValue = tweenValue.animate(
      CurvedAnimation(
        parent: animationController,
        curve: widget.style.animationCurve,
      ),
    )..addListener(() {
        setState(() {});
      });
  }

  void updateAnimationValue(double oldValue) {
    tweenValue
      ..begin = oldValue
      ..end = widget.value;
    animationController
      ..reset()
      ..forward();
  }

  @override
  void initState() {
    super.initState();
    setupAnimationValue();
  }

  @override
  void didUpdateWidget(CircularSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateAnimationValue(oldWidget.value);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapDown: (details) {
            isDrag = false;
            updateSlider(constraints, details.localPosition);
          },
          onPanUpdate: (details) {
            isDrag = true;
            updateSlider(constraints, details.localPosition);
          },
          child: CustomPaint(
            painter: CircularSliderPainter(
              value: animationValue.value,
              min: widget.min,
              max: widget.max,
              draggable: widget.draggable,
              style: widget.style,
            ),
          ),
        );
      },
    );
  }
}
