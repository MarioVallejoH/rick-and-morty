import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/repositories/locations_repository.dart';
import 'package:rick_and_morty_app/src/domain/entities/locations.dart';

/// Locations data provider
///
/// Calls locations repository to fetch Locations data
final locationsProvider = StateProvider.autoDispose<Locations?>((ref) {
  ref.watch(locationsFilterProvider);
  return null;
});

/// Locations current page provider
///
/// Save current locations page
final locationsPageProvider = StateProvider.autoDispose<int>((ref) {
  ref.watch(locationsFilterProvider);
  return 1;
});

/// Locations data provider
///
/// Calls locations repository to fetch Locations data
final locationsFetchProvider = FutureProvider.autoDispose<Locations>((ref) {
  return ref.read(locationsRepositoryProvider).get(
        page: ref.watch(locationsPageProvider),
        filter: ref.watch(locationsFilterProvider),
      );
});

/// Locations data provider
///
/// Calls locations repository to fetch Locations data
final locationFetchProvider = FutureProvider.autoDispose<Location?>((ref) {
  return ref
      .read(locationsRepositoryProvider)
      .getOne(ref.read(locationSelectedProvider)?.id);
});

/// Locations current selection
///
/// Save current location selected
final locationSelectedProvider = StateProvider<Location?>((ref) {
  return null;
});

/// locations current filters
///
/// Save current filters on locations screen
final locationsFilterProvider =
    StateProvider.autoDispose<Map<String, dynamic>>((ref) {
  return {};
});
