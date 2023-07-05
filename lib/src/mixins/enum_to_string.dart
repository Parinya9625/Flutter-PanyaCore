mixin EnumToStringMixin on Enum {
  @override
  String toString() {
    return name;
  }
}
