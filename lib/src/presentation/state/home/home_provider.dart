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
