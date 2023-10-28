import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Home state provider
///
/// Only create a little delay to show a loading screen
final homeStateProvider = FutureProvider<int>((ref) async {
  return await Future.delayed(
    const Duration(
      seconds: 3,
    ),
    () => 0,
  );
});

/// Home screen bottom navbar index
///
/// Save current bottomBar index
final homeBottomBarProvider = StateProvider.autoDispose<int>((ref) {
  return 1;
});
