import 'package:test/test.dart';
import 'package:vendure/vendure.dart';

void main() {
  group('Vendure', () {
    test('addItemToCart', () async {
      final sdk = Vendure('http://localhost:3000/shop-api',
          token:
              '3e09931820c8a9542be087da474bd13f7ded7596a23b15b49fa946a4334d9e32');

      try {
        await sdk.addItemToCart(86, 1);
        // Add assertions based on your expected result
      } catch (e) {
        fail('Error adding item to cart: $e');
      }
    });
  });
}
