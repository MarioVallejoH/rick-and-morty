import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/presentation/views/home/main_screen.dart';

/// Class to manage app routes.
class Routes {
  /// Return app routes
  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      root: (BuildContext context) => const HomeScreen(),
    };
  }

  /// App root route name
  static String root = '/';
}
