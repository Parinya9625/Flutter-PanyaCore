/// A mixin that provides a convenient way to convert an enumeration value
/// to its string representation.
///
/// It overrides the toString() method of the enum and returns the name of
/// the enum value as a string.
///
/// ```dart
/// enum Products with EnumToStringMixin {
///   food,
///   drink,
///   dessert,
/// }
///
/// Products.food.toString(); // "food"
/// ```
///
mixin EnumToStringMixin on Enum {
  @override
  String toString() {
    return name;
  }
}
