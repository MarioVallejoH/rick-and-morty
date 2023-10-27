import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_app/src/config/router/routes.dart';

/// Perform non async navigation task
class Navigation {
  /// Go to Home
  static goHome(
    BuildContext context, {
    bool removeUntil = true,
  }) {
    goTo(
      Routes.root,
      context,
      replacement: true,
    );
  }

  /// Navigator.pop custom implementation
  static goBack(BuildContext context, {VoidCallback? callback}) {
    final navigator = Navigator.of(context);
    callback?.call();
    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  /// Go to named route
  static goTo(
    String route,
    BuildContext context, {
    bool removeUntil = false,
    bool replacement = false,
    Map<String, dynamic> extra = const {},
  }) {
    final navigator = Navigator.of(context);

    Future.delayed(Duration.zero, () {
      if (removeUntil) {
        if (navigator.canPop()) {
          navigator.pop();
        }
        navigator.pushNamedAndRemoveUntil(
          route,
          (Route<dynamic> route) => false,
          arguments: extra,
        );
      } else if (replacement) {
        navigator.pushReplacementNamed(
          route,
          arguments: extra,
        );
      } else {
        navigator.pushNamed(
          route,
          arguments: extra,
        );
      }
    });
  }
}
