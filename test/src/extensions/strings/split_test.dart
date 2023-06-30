import 'package:flutter_test/flutter_test.dart';
import 'package:panya_core/src/extensions/strings/split.dart';

void main() {
  group("Split Extension - splitAndKeep", () {
    test("Contain a word", () {
      List<String> result = "This is a sentence.".splitAndKeep([" is "]);
      expect(result, ["This", " is ", "a sentence."]);
    });

    test("Contain 2 word", () {
      List<String> result = "This is a sentence.".splitAndKeep(
        [" is ", "sentence"],
      );
      expect(result, ["This", " is ", "a ", "sentence", "."]);
    });

    test("Not contain any word", () {
      List<String> result = "This is a sentence.".splitAndKeep(["hello"]);
      expect(result, ["This is a sentence."]);
    });

    test("Space character", () {
      List<String> result = "This is a sentence.".splitAndKeep([" "]);
      expect(result, ["This", " ", "is", " ", "a", " ", "sentence."]);
    });
  });
}
