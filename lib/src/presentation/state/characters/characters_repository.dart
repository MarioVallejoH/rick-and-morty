import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_app/src/domain/entities/characters.dart';

/// Characters data provider
///
/// Calls characters repository to fetch characters data
final charactersProvider = StateProvider.autoDispose<Characters?>((ref) {
  ref.watch(charactersFilterProvider);
  return null;
});

/// characters current page provider
///
/// Save current characters page
final charactersPageProvider = StateProvider.autoDispose<int>((ref) {
  ref.watch(charactersFilterProvider);
  return 1;
});

/// characters current filters
///
/// Save current filters on characters screen
final charactersFilterProvider =
    StateProvider.autoDispose<Map<String, dynamic>>((ref) {
  return {};
});

/// characters data provider
///
/// Calls characters repository to fetch characters data
final charactersFetchProvider = FutureProvider.autoDispose<Characters>((ref) {
  return ref.read(characterRepositoryProvider).get(
        page: ref.watch(charactersPageProvider),
        filter: ref.watch(charactersFilterProvider),
      );
});

/// characters data provider
///
/// Calls characters repository to fetch characters data
final characterFetchProvider = FutureProvider.autoDispose<Character?>((ref) {
  return ref
      .read(characterRepositoryProvider)
      .getOne(ref.read(characterSelectedProvider)?.id);
});

/// characters current selection
///
/// Save current episode selected
final characterSelectedProvider = StateProvider<Character?>((ref) {
  return null;
});
