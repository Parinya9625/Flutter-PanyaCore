import 'package:flutter_test/flutter_test.dart';
import 'package:panya_core/src/extensions/numbers/normalize.dart';

void main() {
  group("Normalize Extension - normalizeFrom", () {
    test('Case 1: Value equals the minimum', () {
      double result = 0.normalizeFrom(min: 0, max: 5);
      expect(result, equals(0.0));
    });

    test("Case 2: Value equals the maximum", () {
      double result = 5.normalizeFrom(min: 0, max: 5);
      expect(result, equals(1.0));
    });

    test("Case 3: Value within the range", () {
      double result = 2.5.normalizeFrom(min: 0, max: 5);
      expect(result, equals(0.5));
    });

    test("Case 4: Negative value", () {
      double result = (-10.0).normalizeFrom(min: -20, max: 0);
      expect(result, equals(0.5));
    });

    test("Case 5: Assert Error - min > max", () {
      expect(() {
        1.normalizeFrom(min: 1, max: -1);
      }, throwsAssertionError);
    });

    test("Case 6: Assert Error - Value out of range", () {
      expect(() {
        50.normalizeFrom(min: 0, max: 1);
      }, throwsAssertionError);
    });
  });

  group("Normalize Extension - denormalizeTo", () {
    test("Case 1: 0% denormalization", () {
      double result = 0.0.denormalizeTo(min: 0, max: 10);
      expect(result, equals(0.0));
    });

    test("Case 2: 50% denormalization", () {
      double result = 0.5.denormalizeTo(min: 0, max: 10);
      expect(result, equals(5.0));
    });

    test("Case 3: 100% denormalization", () {
      double result = 1.denormalizeTo(min: 0, max: 10);
      expect(result, equals(10));
    });

    test("Case 4: 50% denormalization with negative min", () {
      double result = 0.5.denormalizeTo(min: -10, max: 10);
      expect(result, equals(0));
    });

    test("Case 5: Assert Error - min > max", () {
      expect(() {
        1.denormalizeTo(min: 1, max: -1);
      }, throwsAssertionError);
    });

    test("Case 6: Assert Error - Negative value", () {
      expect(() {
        -10.denormalizeTo(min: 0, max: 10);
      }, throwsAssertionError);
    });
  });
}
