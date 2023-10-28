import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_app/src/domain/entities/characters.dart';

/// Characters data provider
///
/// Calls characters repository to fetch characters data
final charactersProvider = StateProvider.autoDispose<Characters?>((ref) {
  return null;
});

/// characters current page provider
///
/// Save current characters page
final charactersPageProvider = StateProvider.autoDispose<int>((ref) {
  return 1;
});

/// characters data provider
///
/// Calls characters repository to fetch characters data
final charactersFetchProvider = FutureProvider.autoDispose<Characters>((ref) {
  return ref
      .read(characterRepositoryProvider)
      .get(page: ref.watch(charactersPageProvider));
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
