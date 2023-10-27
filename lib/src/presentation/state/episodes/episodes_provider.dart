import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/dataSource/api_data_source.dart';
import 'package:rick_and_morty_app/src/data/repositories/episodes_repository.dart';
import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';

/// Episodes data provider
///
/// Calls episodes repository to fetch Episodes data
final episodesProvider = StateProvider.autoDispose<Episodes?>((ref) {
  return null;
});

/// Episodes current page provider
///
/// Save current episodes page
final episodesPageProvider = StateProvider.autoDispose<int>((ref) {
  return 1;
});

/// Episodes data provider
///
/// Calls episodes repository to fetch Episodes data
final episodesFetchProvider = FutureProvider.autoDispose<Episodes>((ref) {
  final episodesRepo = EpisodesGQLRepository(ref.read(dataSourceProvider));
  return episodesRepo.get(page: ref.watch(episodesPageProvider));
});

/// Episodes current selection
///
/// Save current episode selected
final episodeSelectedProvider = StateProvider.autoDispose<Episode?>((ref) {
  return null;
});
