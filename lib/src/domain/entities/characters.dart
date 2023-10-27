// ignore_for_file: constant_identifier_names

import 'package:rick_and_morty_app/src/domain/entities/info.dart';
import 'package:rick_and_morty_app/src/domain/entities/locations.dart';
import 'package:rick_and_morty_app/src/utils/enums.dart';
import 'package:rick_and_morty_app/src/utils/utils/global_locator.dart';

/// Characters entity
///
/// Used to manage fetched characters data
class Characters {
  /// Class constructor
  Characters({
    required this.info,
    required this.characters,
  });

  /// From Json factory
  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        info: Info.fromJson(json['info']),
        characters: List<Character>.from(
          json['results'].map((x) => Character.fromJson(x)),
        ),
      );

  /// Characters general information
  Info info;

  /// List of characters containing each character data
  List<Character> characters;
}

/// Character data
class Character {
  /// Class constructor
  Character({
    required this.name,
    required this.id,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.created,
    required this.location,
    required this.origin,
  });

  /// From Json Map factory
  factory Character.fromJson(Map json) => Character(
        name: json['name'] ?? '',
        id: json['id'] ?? '',
        status: statusValues.map[json['status'] ?? '']!,
        species: json['species'] ?? '',
        type: json['type'] ?? '',
        gender: genderValues.map[json['gender'] ?? '']!,
        image: json['image'] ?? '',
        created: DateTime.tryParse(json['created'] ?? ''),
        location: json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        origin:
            json['origin'] != null ? Location.fromJson(json['origin']) : null,
      );

  /// Character name
  String name;

  /// Character Id
  String id;

  /// Character status
  Status status;

  /// Character sp
  String species;

  /// Character type
  String type;

  /// Character gender
  Gender gender;

  /// Character image
  String image;

  /// Character created date
  DateTime? created;

  /// Character location data
  Location? location;

  /// Character origin data
  Location? origin;

  /// Parse a list of entities from a Json List<Map>
  static List<Character> fromJsonList(List data) {
    final List<Character> result = [];
    for (var element in data) {
      try {
        result.add(Character.fromJson(element as Map));
      } catch (e) {
        GlobalLocator.appLogger.e(e);
      }
    }
    return result;
  }
}

/// Genders
// ignore: public_member_api_docs
enum Gender { FEMALE, MALE, UNKNOWN }

/// Gender posible values
final genderValues = EnumValues(
  {
    'Female': Gender.FEMALE,
    'Male': Gender.MALE,
    'unknown': Gender.UNKNOWN,
    '': Gender.UNKNOWN,
  },
);

/// Character status enum
// ignore: public_member_api_docs
enum Status { ALIVE, DEAD, UNKNOWN }

/// Character status mapped string to Enum
final statusValues = EnumValues({
  'Alive': Status.ALIVE,
  'Dead': Status.DEAD,
  'unknown': Status.UNKNOWN,
  '': Status.UNKNOWN,
});
