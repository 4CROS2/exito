import 'package:exito/src/features/cart/data/model/cart_item_mode.dart';

abstract interface class CartDatasource {
  Future<void> addToCart({required CartItemModel item});
  Future<void> removeFromCart({required String id});
  Future<List<Map<String, dynamic>>> getCartItems();
}
