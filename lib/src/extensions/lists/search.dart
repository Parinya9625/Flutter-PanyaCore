extension SearchListExtension<T> on List<T> {
  /// The first element that satisfies the given predicate [test] if not
  /// return `null`.
  ///
  /// ```dart
  /// List<String> data = ["A", "B", "C"];
  /// data.firstWhereOrNull((element) => element == "A"); // A
  /// data.firstWhereOrNull((element) => element == "Z"); // null
  /// ```
  T? firstWhereOrNull(bool Function(T element) test) {
    for (T element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
