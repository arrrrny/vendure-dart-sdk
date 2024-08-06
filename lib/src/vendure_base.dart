import 'package:graphql/client.dart';
import 'package:vendure/src/fragments/active_order_fragment.dart';
import 'package:vendure/src/mutations/add_item_to_order_mutation.dart';

class Vendure {
  final GraphQLClient _client;

  Vendure(String endpoint, {String? token})
      : _client = GraphQLClient(
          link: HttpLink(endpoint, defaultHeaders: {
            if (token != null) 'Authorization': 'Bearer $token',
          }),
          cache: GraphQLCache(),
        );

  Future<void> addItemToCart(int productVariantId, int quantity) async {
    final mutation = gql(activeOrderFragment + addItemToOrderMutation);

    final options = MutationOptions(
      document: mutation,
      variables: {
        'productVariantId': productVariantId,
        'quantity': quantity,
      },
    );
    print(options);
    final result = await _client.mutate(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data?['addItemToOrder'];
    if (data != null && data['__typename'] == 'ErrorResult') {
      throw Exception(data['message']);
    }
  }
}
