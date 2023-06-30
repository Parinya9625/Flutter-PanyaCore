import 'package:flutter_test/flutter_test.dart';
import 'package:panya_core/src/utils/number_range/number_range.dart';

void main() {
  group("NumberRange Util - create", () {
    test("Range 0 to 9 (10 Items)", () {
      List<num> result = NumberRange.create(stop: 10);
      expect(result, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    });

    test("Range 5 to 9 (5 Items)", () {
      List<num> result = NumberRange.create(start: 5, stop: 10);
      expect(result, [5, 6, 7, 8, 9]);
    });

    test("Range 2 to 10 step 2 (4 Items)", () {
      List<num> result = NumberRange.create(start: 2, stop: 10, step: 2);
      expect(result, [2, 4, 6, 8]);
    });

    test("Range 10 to 1 step 1 (0 Items)", () {
      List<num> result = NumberRange.create(start: 10, stop: 1, step: 1);
      expect(result, []);
    });

    test("Range 1 to 1 (0 Items)", () {
      List<num> result = NumberRange.create(start: 1, stop: 1);
      expect(result, []);
    });

    test("Range 10 to 0 step -1 (10 Items)", () {
      List<num> result = NumberRange.create(start: 10, stop: 0, step: -1);
      expect(result, [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]);
    });

    test("Range 10 to 0 step -3 (4 Items)", () {
      List<num> result = NumberRange.create(start: 10, stop: 0, step: -3);
      expect(result, [10, 7, 4, 1]);
    });

    test("Range 1 to 1 step -1 (0 Items)", () {
      List<num> result = NumberRange.create(start: 1, stop: 1, step: -1);
      expect(result, []);
    });
  });

  group("NumberRange Util - make", () {
    test("Make 10 numbers", () {
      List<num> result = NumberRange.make(10);
      expect(result, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
    });

    test("Make 10 numbers that start with 10", () {
      List<num> result = NumberRange.make(10, start: 10);
      expect(result, [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]);
    });

    test("Make 10 numbers that step up 2", () {
      List<num> result = NumberRange.make(10, step: 2);
      expect(result, [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]);
    });

    test("Make 10 numbers that start with 2 and step up 3", () {
      List<num> result = NumberRange.make(10, start: 2, step: 3);
      expect(result, [2, 5, 8, 11, 14, 17, 20, 23, 26, 29]);
    });

    test("Make 13 numbers that start with -50 and step up 5", () {
      List<num> result = NumberRange.make(13, start: -50, step: 5);
      expect(
        result,
        [-50, -45, -40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10],
      );
    });
  });
}
