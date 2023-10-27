import 'package:rick_and_morty_app/src/data/dataSource/api_data_source.dart';
import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';

/// Episodes GQL Repository
///
/// Manages GQL query from app search and filters and return Episodes
/// data
abstract class EpisodesGQLRepositoryI {
  /// Class constructor
  EpisodesGQLRepositoryI(this.api);

  /// ApiDataSource instance
  final ApiDataSource api;

  /// Episodes GQL query builder
  String buildQuery({required page, Map<String, dynamic> filter = const {}});
  // '{info {count,pages}results {name,id,air_date,episode,created}';

  /// Get Episodes data with optional filters
  Future<Episodes> get({int page = 1, Map<String, dynamic>? filter});
}
