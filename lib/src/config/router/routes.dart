import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/presentation/screens.dart';

/// Class to manage app routes.
class Routes {
  /// Return app routes
  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      root: (BuildContext context) => const HomeScreen(),
      episodes: (BuildContext context) => const EpisodesScreen(),
      episode: (BuildContext context) => const EpisodeScreen(),
    };
  }

  /// App root route name
  static String root = '/';

  /// App episodes page route name
  static String episodes = '/episodes';

  /// App episode page route name
  static String episode = '/episode';
}
