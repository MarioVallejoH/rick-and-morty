import 'package:rick_and_morty_app/src/data/dataSource/api_data_source.dart';
import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';
import 'package:rick_and_morty_app/src/domain/entities/request_data.dart';
import 'package:rick_and_morty_app/src/domain/repositories/episodes_gql_repository.dart';

/// Implementation episodes repo
class EpisodesGQLRepository implements EpisodesGQLRepositoryI {
  @override
  Future<Episodes> get({int page = 0, Map<String, dynamic>? filter}) async {
    final requestData = RequestData(
      path: '/graphql',
      queryParameters: {
        'query': buildQuery(page: page, filter: filter ?? {}),
      },
    );
    final result = await ApiDataSource().request(
      requestData: requestData,
    );
    Episodes? data = Episodes.fromJson(
      result['data']['characters'],
    );
    return data;
  }

  @override
  String buildQuery({required page, Map<String, dynamic> filter = const {}}) {
    String query = '';
    query = 'episodes(page:$page FILTER_HERE)'
        '{info {count,pages}results {name,id,air_date,episode,created}';
    if (filter.isEmpty) {
      query.replaceAll('FILTER_HERE', '');
    }
    return query;
  }
}
