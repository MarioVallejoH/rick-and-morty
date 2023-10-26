import 'dart:convert';

import 'package:rick_and_morty_app/src/domain/entities/info.dart';

class Locations {
  Locations({
    required this.info,
    required this.locations,
  });

  factory Locations.fromRawJson(String str) =>
      Locations.fromJson(json.decode(str));

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        info: Info.fromJson(json['info']),
        locations: List<Location>.from(
          json['locations'].map((x) => Location.fromJson(x)),
        ),
      );
  Info info;
  List<Location> locations;
}

class Location {
  Location({
    required this.name,
    required this.id,
    required this.type,
    required this.dimension,
    required this.created,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'],
        id: json['id'],
        type: json['type'],
        dimension: json['dimension'],
        created: DateTime.parse(json['created']),
      );
  String name;
  String id;
  String type;
  String dimension;
  DateTime created;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'type': type,
        'dimension': dimension,
        'created': created.toIso8601String(),
      };
}
