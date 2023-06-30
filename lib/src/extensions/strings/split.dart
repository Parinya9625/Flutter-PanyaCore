extension SplitStringExtensions on String {
  /// Split the string into chunck and keep all words
  ///
  /// Ref. https://medium.com/@shemar.gordon32/how-to-split-and-keep-the-delimiter-s-d433fb697c65
  List<String> splitAndKeep(
    List<String> words, {
    bool multiLine = false,
    bool caseSensitive = true,
    bool unicode = false,
    bool dotAll = false,
  }) {
    if (words.isEmpty) return [this];

    var wordsGroup = "(${(words).join("|")})";
    var regex = RegExp(
      "(?=$wordsGroup)|(?<=$wordsGroup)",
      multiLine: multiLine,
      caseSensitive: caseSensitive,
      unicode: unicode,
      dotAll: dotAll,
    );

    return split(regex);
  }
}
