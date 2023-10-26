import 'package:rick_and_morty_app/src/domain/entities/characters.dart';

/// Characters GQL Repository
///
/// Manages GQL query from app search and filters and return characters
/// data
abstract class CharactersGQLRepositoryI {
  /// Characters GQL query builder
  String buildQuery(Map<String, dynamic>? filter);

  /// Get characters data with optional filters
  Future<Characters> get({int page = 0, Map<String, dynamic>? filter});
}
