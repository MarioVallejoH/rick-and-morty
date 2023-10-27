import 'package:rick_and_morty_app/src/data/dataSource/api_data_source.dart';
import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';
import 'package:rick_and_morty_app/src/domain/entities/request_data.dart';
import 'package:rick_and_morty_app/src/domain/repositories/episodes_gql_repository.dart';

/// Implementation episodes repo
class EpisodesGQLRepository implements EpisodesGQLRepositoryI {
  ///
  EpisodesGQLRepository(this.api);

  @override
  final ApiDataSource api;
  @override
  Future<Episodes> get({int page = 1, Map<String, dynamic>? filter}) async {
    final requestData = RequestData(
      path: '/graphql',
      queryParameters: {
        'query': buildQuery(page: page, filter: filter ?? {}),
      },
    );
    final result = await api.request(
      requestData: requestData,
    );
    Episodes? data = Episodes.fromJson(
      result['data']['episodes'],
    );
    return data;
  }

  @override
  String buildQuery({required page, Map<String, dynamic> filter = const {}}) {
    String query = '';

    String filterString = '';
    if (filter.isNotEmpty) {
      filterString += 'filter {';
      filter.forEach((key, value) {
        filterString += '$key:"$value"';
      });
      filterString += '}';
    }
    query = 'query {episodes(page:$page, $filterString)'
        '{info {count,pages}results {name,id,air_date,episode,created,}}}';
    return query;
  }

  @override
  Future<Episode> getOne(int id) async {
    const query =
        'query {episode(id:1) {name,id,air_date,episode,created,characters{id,name,status,species,gender,image,origin{id,name,type,dimension,created},location{id,name,type,dimension,created}}}}';
    final requestData = RequestData(
      path: '/graphql',
      queryParameters: {
        'query': query,
      },
    );
    final result = await api.request(
      requestData: requestData,
    );
    Episodes? data = Episodes.fromJson(
      result['data']['episodes'],
    );
    return data.episodes.first;
  }
}
