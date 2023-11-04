import 'package:get_it/get_it.dart';
import 'package:gql_client/gql_client.dart';

final getIt = GetIt.instance;

Future<void> registerServices() async {
  const gqlConfig = GraphqlConfig(
    apiEndpoint: "http://localhost:3000/shop-api",
  );

  getIt.registerSingleton<GraphQLClient>(GraphQLClient.create(gqlConfig));
}
