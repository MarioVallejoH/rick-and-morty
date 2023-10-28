import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/dataSource/api_data_source.dart';
import 'package:rick_and_morty_app/src/domain/entities/characters.dart';
import 'package:rick_and_morty_app/src/domain/entities/request_data.dart';
import 'package:rick_and_morty_app/src/domain/repositories/characters_gql_repository.dart';

/// Implementation Character repo
class CharacterGQLRepository implements CharactersGQLRepositoryI {
  ///
  CharacterGQLRepository(this.api);

  @override
  final ApiDataSource api;
  @override
  Future<Characters> get({int page = 1, Map<String, dynamic>? filter}) async {
    final requestData = RequestData(
      path: '/graphql',
      queryParameters: {
        'query': buildQuery(page: page, filter: filter ?? {}),
      },
    );
    final result = await api.request(
      requestData: requestData,
    );
    Characters? data = Characters.fromJson(
      result['data']['characters'],
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
        'query {characters(page: $page, $filterString) {info {count,pages}results {name,id,status,image,type,gender,episode{id,name,air_date,episode,created},origin{id,name,type,dimension,created},location{id,name,type,dimension,created},created}}}';
    return query;
  }

  @override
  Future<Character?> getOne(String? id) async {
    if (id == null) return null;
    final query =
        'query {character(id:$id){name,id,status,image,type,gender,episode{id,name,air_date,episode,created},origin{id,name,type,dimension,created},location{id,name,type,dimension,created},created}}';
    final requestData = RequestData(
      path: '/graphql',
      queryParameters: {
        'query': query,
      },
    );
    final result = await api.request(
      requestData: requestData,
    );
    Character? data = Character.fromJson(
      result['data']['character'],
    );
    return data;
  }
}

/// Character repository provider
final characterRepositoryProvider =
    StateProvider.autoDispose<CharactersGQLRepositoryI>(
  (ref) {
    return CharacterGQLRepository(ref.read(dataSourceProvider));
  },
);
