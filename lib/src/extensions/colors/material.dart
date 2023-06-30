import 'dart:math' as math;
import 'package:flutter/material.dart';

extension MaterialColorExtension on Color {
  MaterialColor toMaterialColor() {
    return MaterialColor(value, {
      50: withTint(0.9),
      100: withTint(0.8),
      200: withTint(0.6),
      300: withTint(0.4),
      400: withTint(0.2),
      500: this,
      600: withShade(0.1),
      700: withShade(0.2),
      800: withShade(0.3),
      900: withShade(0.4),
    });
  }

  Color withTint(double factor) {
    return Color.fromRGBO(
      _withTint(red, factor),
      _withTint(green, factor),
      _withTint(blue, factor),
      opacity,
    );
  }

  Color withShade(double factor) {
    return Color.fromRGBO(
      _withShade(red, factor),
      _withShade(green, factor),
      _withShade(blue, factor),
      opacity,
    );
  }

  int _withTint(int value, double factor) {
    return math.max(
      0,
      math.min((value + ((255 - value) * factor)).round(), 255),
    );
  }

  int _withShade(int value, double factor) {
    return math.max(
      0,
      math.min(value - (value * factor).round(), 255),
    );
  }
}