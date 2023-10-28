import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/repositories/locations_repository.dart';
import 'package:rick_and_morty_app/src/domain/entities/locations.dart';

/// Locations data provider
///
/// Calls locations repository to fetch Locations data
final locationsProvider = StateProvider.autoDispose<Locations?>((ref) {
  return null;
});

/// Locations current page provider
///
/// Save current locations page
final locationsPageProvider = StateProvider.autoDispose<int>((ref) {
  return 1;
});

/// Locations data provider
///
/// Calls locations repository to fetch Locations data
final locationsFetchProvider = FutureProvider.autoDispose<Locations>((ref) {
  return ref
      .read(locationsRepositoryProvider)
      .get(page: ref.watch(locationsPageProvider));
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
