import 'package:gql_client/gql_client.dart';
import 'package:jumia_shop/server/graphql/queries/get_collections.g.dart';
import 'package:jumia_shop/server/models/category.dart';
import 'package:jumia_shop/server/services/injector.dart';
import 'package:jumia_shop/utils/base_provider.dart';

class CategoryProvider extends BaseProvider<List<Category>> {
  GraphQLClient get gqlClient => getIt.get<GraphQLClient>();

  CategoryProvider();

  final Map<String, Category> _dataBag = {};

  List<Category> get categories =>
      _dataBag.values.toList()..sort((a, b) => b.children.length.compareTo(a.children.length));

  Future<void> fetchCategories({bool refresh = false}) async {
    try {
      final result = await gqlClient.runQuery(
        GetCollectionsRequest(),
        resultKey: 'collections',
      );

      final categories = (result!['items'] as Iterable).map((e) => Category.fromJson(e)).toList();

      for (final p in categories) {
        _dataBag[p.id] = p;
      }

      addEvent(ProviderEvent.success(data: categories));
    } on NetworkError catch (e) {
      addEvent(ProviderEvent.error(message: e.message));
    }
  }

  @override
  void clear() {
    _dataBag.clear();
    super.clear();
  }
}
