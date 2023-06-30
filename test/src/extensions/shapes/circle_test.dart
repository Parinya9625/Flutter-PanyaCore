import 'package:flutter_test/flutter_test.dart';
import 'package:panya_core/src/extensions/shapes/circle.dart';

void main() {
  group("Circle Offset Extension - findAngle", () {
    test("0,0 to 0,1", () {
      double result = Offset.zero.findAngle(const Offset(0, 1));
      expect(double.parse(result.toStringAsFixed(4)), equals(1.5708));
    });

    test("0,0 to -1,0", () {
      double result = Offset.zero.findAngle(const Offset(-1, 0));
      expect(double.parse(result.toStringAsFixed(4)), equals(3.1416));
    });
  });

  group("Circle Number Extension - toDegree", () {
    test("90 Degree", () {
      double result = Offset.zero.findAngle(const Offset(0, 1)).toDegree();
      expect(result, equals(90));
    });

    test("180 Degree", () {
      double result = Offset.zero.findAngle(const Offset(-1, 0)).toDegree();
      expect(result, equals(180));
    });
  });

  group("Circle Number Extension - to360Degree", () {
    test("90 Degree", () {
      double result = Offset.zero.findAngle(const Offset(0, 1)).to360Degree();
      expect(result, equals(90));
    });

    test("180 Degree", () {
      double result = Offset.zero.findAngle(const Offset(-1, 0)).to360Degree();
      expect(result, equals(180));
    });
  });

  group("Circle Number Extension - toAngle", () {
    test("90 Degree to angle", () {
      double result = 90.toAngle();
      expect(double.parse(result.toStringAsFixed(4)), equals(1.5708));
    });

    test("180 Degree to angle", () {
      double result = 180.toAngle();
      expect(double.parse(result.toStringAsFixed(4)), equals(3.1416));
    });
  });
}
