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

/// Episodes data provider
///
/// Calls episodes repository to fetch Episodes data
final episodesFetchProvider = FutureProvider.autoDispose<Episodes>((ref) {
  final episodesRepo = EpisodesGQLRepository(ref.read(dataSourceProvider));
  return episodesRepo.get();
});
