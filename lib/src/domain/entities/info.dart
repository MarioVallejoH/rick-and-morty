/// Characters general data
class Info {
  /// Class constructor
  Info({
    required this.count,
    required this.pages,
  });

  /// From map factory
  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json['count'],
        pages: json['pages'],
      );

  /// No of characters found
  int count;

  /// No of total pages (grouped by 10)
  int pages;
}
