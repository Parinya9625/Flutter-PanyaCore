import 'package:flutter_test/flutter_test.dart';
import 'package:panya_core/panya_core.dart';

void main() {
  group("Percent Extension - percentOf", () {
    test("50% of 100", () {
      double result = 50.percentOf(max: 100);
      expect(result, equals(50));
    });

    test("25% of 500", () {
      double result = 25.percentOf(max: 500);
      expect(result, equals(125));
    });

    test("10% of 25 - 300", () {
      double result = 10.percentOf(min: 25, max: 300);
      expect(result, equals(52.5));
    });

    test("50% of -100 - 100", () {
      double result = 50.percentOf(min: -100, max: 100);
      expect(result, equals(0));
    });

    test("125% of 200", () {
      double result = 125.percentOf(max: 200);
      expect(result, equals(250));
    });

    test("-10% of 200", () {
      double result = (-10).percentOf(max: 200);
      expect(result, equals(-20));
    });

    test("-125% of 200", () {
      double result = (-125).percentOf(max: 200);
      expect(result, equals(-250));
    });

    test("Assert Error - min > max", () {
      expect(() {
        1.percentOf(min: 500, max: 1);
      }, throwsAssertionError);
    });
  });

  group("Percent Extension - normalizePercentOf", () {
    test("0.5 of 100", () {
      double result = 0.5.normalizePercentOf(max: 100);
      expect(result, equals(50));
    });

    test("0.25 of 500", () {
      double result = 0.25.normalizePercentOf(max: 500);
      expect(result, equals(125));
    });

    test("0.1 of 25 - 300", () {
      double result = 0.1.normalizePercentOf(min: 25, max: 300);
      expect(result, equals(52.5));
    });

    test("0.5 of -100 - 100", () {
      double result = 0.5.normalizePercentOf(min: -100, max: 100);
      expect(result, equals(0));
    });

    test("1.25 of 200", () {
      double result = 1.25.normalizePercentOf(max: 200);
      expect(result, equals(250));
    });

    test("-0.1 of 200", () {
      double result = (-0.1).normalizePercentOf(max: 200);
      expect(result, equals(-20));
    });

    test("-1.25 of 200", () {
      double result = (-1.25).normalizePercentOf(max: 200);
      expect(result, equals(-250));
    });

    test("Assert Error - min > max", () {
      expect(() {
        1.normalizePercentOf(min: 500, max: 1);
      }, throwsAssertionError);
    });
  });
}
