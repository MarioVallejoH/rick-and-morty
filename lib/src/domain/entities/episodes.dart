import 'package:rick_and_morty_app/src/domain/entities/characters.dart';
import 'package:rick_and_morty_app/src/domain/entities/info.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// Class to manage fetched episodes data
class Episodes {
  ///
  Episodes({
    required this.info,
    required this.episodes,
  });

  /// From Map factory
  factory Episodes.fromJson(Map<String, dynamic> json) => Episodes(
        info: Info.fromJson(json['info']),
        episodes: List<Episode>.from(
          json['results'].map((x) => Episode.fromJson(x)),
        ),
      );

  /// Episodes fetched data information
  Info info;

  /// Episodes list
  List<Episode> episodes;
}

/// Episode data
class Episode {
  ///
  Episode({
    required this.name,
    required this.id,
    required this.airDate,
    required this.episode,
    required this.created,
    required this.characters,
  });

  /// From Map factory
  factory Episode.fromJson(Map json) => Episode(
        name: json['name'],
        id: json['id'],
        airDate: json['air_date'],
        episode: json['episode'],
        created: DateTime.tryParse(json['created'] ?? ''),
        characters: json['characters'] != null
            ? Character.fromJsonList(json['characters'])
            : null,
      );

  /// Episode name
  String name;

  /// Episode id
  String id;

  /// Episode release date
  String airDate;

  /// Episode code
  String episode;

  /// Episode create date
  DateTime? created;

  /// Characters
  List<Character>? characters;

  /// Parse a list of entities from a Json List<Map>
  static List<Episode> fromJsonList(List data) {
    final List<Episode> result = [];
    for (var element in data) {
      try {
        result.add(Episode.fromJson(element as Map));
      } catch (e) {
        GlobalLocator.appLogger.e(e);
      }
    }
    return result;
  }
}
