/// Class to manage enum values
class EnumValues<T> {
  ///
  EnumValues(this.map);

  ///
  Map<String, T> map;

  ///
  late Map<T, String> reverseMap;

  /// Parse enum values to string
  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
