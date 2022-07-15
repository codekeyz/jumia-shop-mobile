import 'package:jumia_shop/server/graphql/queries/get_products.g.dart';
import 'package:jumia_shop/server/models/product.dart';
import 'package:jumia_shop/server/services/injector.dart';
import 'package:jumia_shop/utils/base_provider.dart';
import 'package:gql_client/gql_client.dart';

class ProductsProvider extends BaseProvider<List<Product>> {
  GraphQLClient get gqlClient => getIt.get<GraphQLClient>();

  ProductsProvider();

  final Map<String, Product> _dataBag = {};

  List<Product> get products => _dataBag.values.toList();

  Future<void> fetchProducts({bool refresh = false}) async {
    try {
      final result = await gqlClient.runQuery(
        GetProductsRequest(),
        resultKey: 'products',
      );

      final products = (result!['items'] as Iterable)
          .map((e) => Product.fromJson(e))
          .toList();

      for (final p in products) {
        _dataBag[p.id] = p;
      }

      addEvent(ProviderEvent.success(data: products));
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
