import 'package:flutter_test/flutter_test.dart';
import 'package:panya_core/src/mixins/enum_to_string.dart';

enum Products with EnumToStringMixin {
  food,
  drink,
  dessert,
}

void main() {
  group("Enum to String Mixin", () {
    test("Convert enum to string with toString()", () {
      String result = Products.food.toString();
      expect(result, "food");
    });

    test("Convert enum to string with \${} ", () {
      String result = "${Products.drink}";
      expect(result, "drink");
    });
  });
}
