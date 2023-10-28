import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/repositories/episodes_repository.dart';
import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';

/// Episodes data provider
///
/// Calls episodes repository to fetch Episodes data
final episodesProvider = StateProvider.autoDispose<Episodes?>((ref) {
  ref.watch(episodesFilterProvider);
  return null;
});

/// Episodes current page provider
///
/// Save current episodes page
final episodesPageProvider = StateProvider.autoDispose<int>((ref) {
  ref.watch(episodesFilterProvider);
  return 1;
});

/// Episodes data provider
///
/// Calls episodes repository to fetch Episodes data
final episodesFetchProvider = FutureProvider.autoDispose<Episodes>((ref) {
  return ref.read(episodesRepositoryProvider).get(
        page: ref.watch(episodesPageProvider),
        filter: ref.watch(episodesFilterProvider),
      );
});

/// Episodes data provider
///
/// Calls episodes repository to fetch Episodes data
final episodeFetchProvider = FutureProvider.autoDispose<Episode?>((ref) {
  return ref
      .read(episodesRepositoryProvider)
      .getOne(ref.read(episodeSelectedProvider)?.id);
});

/// Episodes current selection
///
/// Save current episode selected
final episodeSelectedProvider = StateProvider<Episode?>((ref) {
  return null;
});

/// episodes current filters
///
/// Save current filters on episodes screen
final episodesFilterProvider =
    StateProvider.autoDispose<Map<String, dynamic>>((ref) {
  return {};
});
