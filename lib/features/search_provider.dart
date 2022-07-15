import 'package:gql_client/gql_client.dart';
import 'package:jumia_shop/server/graphql/queries/search.g.dart';
import 'package:jumia_shop/server/models/search.dart';
import 'package:jumia_shop/server/services/injector.dart';
import 'package:jumia_shop/utils/base_provider.dart';

class SearchProvider extends BaseProvider<SearchResponse?> {
  GraphQLClient get gqlClient => getIt.get<GraphQLClient>();

  Future<void> search(SearchInput input) async {
    try {
      final _result = await gqlClient.runQuery(SearchRequest(input), resultKey: 'search');
      addEvent(ProviderEvent.success(data: SearchResponse.fromJson(_result!)));
    } on NetworkError catch (e) {
      addEvent(ProviderEvent.error(message: e.message));
    }
  }
}
