import 'package:rick_and_morty_app/src/data/dataSource/api_data_source.dart';
import 'package:rick_and_morty_app/src/domain/entities/characters.dart';

/// Characters GQL Repository
///
/// Manages GQL query from app search and filters and return characters
/// data
abstract class CharactersGQLRepositoryI {
  ///
  CharactersGQLRepositoryI(this.api);

  /// ApiDataSource instance
  final ApiDataSource api;

  /// Characters GQL query builder
  String buildQuery({required page, required Map<String, dynamic> filter});

  /// Get characters data with optional filters
  Future<Characters> get({int page = 1, Map<String, dynamic>? filter});

  /// Get one episode for a given id
  Future<Character?> getOne(String? id);
}
