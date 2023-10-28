import 'package:rick_and_morty_app/src/domain/entities/info.dart';

/// Locations data
class Locations {
  ///
  Locations({
    required this.info,
    required this.locations,
  });

  /// From map factory
  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        info: Info.fromJson(json['info']),
        locations: List<Location>.from(
          json['results'].map((x) => Location.fromJson(x)),
        ),
      );

  /// Locations info
  Info info;

  /// locations list
  List<Location> locations;
}

/// Location data detailed
class Location {
  ///
  Location({
    required this.name,
    required this.id,
    required this.type,
    required this.dimension,
    required this.created,
  });

  /// From Map factory
  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'],
        id: json['id'],
        type: json['type'],
        dimension: json['dimension'],
        created: DateTime.tryParse(json['created'] ?? ''),
      );

  /// Location name
  String? name;

  /// Location id
  String? id;

  /// Location type
  String? type;

  /// Location dimension
  String? dimension;

  /// Location create date
  DateTime? created;
}
