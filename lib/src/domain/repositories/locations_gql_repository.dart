import 'package:rick_and_morty_app/src/data/dataSource/api_data_source.dart';
import 'package:rick_and_morty_app/src/domain/entities/locations.dart';

/// Locations GQL Repository
///
/// Manages GQL query from app search and filters and return Locations
/// data
abstract class LocationsGQLRepositoryI {
  ///
  LocationsGQLRepositoryI(this.api);

  /// ApiDataSource instance
  final ApiDataSource api;

  /// Locations GQL query builder
  String buildQuery({required page, required Map<String, dynamic> filter});

  /// Get locations data with optional filters
  Future<Locations> get({int page = 1, Map<String, dynamic>? filter});
}
