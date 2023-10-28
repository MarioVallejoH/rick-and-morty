import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/dataSource/api_data_source.dart';
import 'package:rick_and_morty_app/src/domain/entities/locations.dart';
import 'package:rick_and_morty_app/src/domain/entities/request_data.dart';
import 'package:rick_and_morty_app/src/domain/repositories/locations_gql_repository.dart';

/// Implementation episodes repo
class LocationsGQLRepository implements LocationsGQLRepositoryI {
  ///
  LocationsGQLRepository(this.api);

  @override
  final ApiDataSource api;
  @override
  Future<Locations> get({int page = 1, Map<String, dynamic>? filter}) async {
    final requestData = RequestData(
      path: '/graphql',
      queryParameters: {
        'query': buildQuery(page: page, filter: filter ?? {}),
      },
    );
    final result = await api.request(
      requestData: requestData,
    );
    Locations? data = Locations.fromJson(
      result['data']['locations'],
    );
    return data;
  }

  @override
  String buildQuery({required page, Map<String, dynamic> filter = const {}}) {
    String query = '';

    String filterString = '';
    if (filter.isNotEmpty) {
      filterString += 'filter: {';
      filter.forEach((key, value) {
        filterString += '$key:"$value",';
      });
      filterString += '}';
    }
    query =
        'query {locations(page: $page$filterString) {info {count,pages}results {name,id,type,dimension,created}}}';
    return query;
  }

  @override
  Future<Location?> getOne(String? id) async {
    if (id == null) return null;
    final query =
        'query {location(id:$id) {name,id,type,dimension,residents{id,name,status,species,status,gender,image,created}}}';
    final requestData = RequestData(
      path: '/graphql',
      queryParameters: {
        'query': query,
      },
    );
    final result = await api.request(
      requestData: requestData,
    );
    Location? data = Location.fromJson(
      result['data']['location'],
    );
    return data;
  }
}

/// Locations repository provider
final locationsRepositoryProvider =
    StateProvider.autoDispose<LocationsGQLRepositoryI>(
  (ref) {
    return LocationsGQLRepository(ref.read(dataSourceProvider));
  },
);
