import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';

/// Episodes GQL Repository
///
/// Manages GQL query from app search and filters and return Episodes
/// data
abstract class EpisodesGQLRepositoryI {
  /// Episodes GQL query builder
  String buildQuery({required page, Map<String, dynamic> filter = const {}});
  // '{info {count,pages}results {name,id,air_date,episode,created}';

  /// Get Episodes data with optional filters
  Future<Episodes> get({int page = 0, Map<String, dynamic>? filter});
}
