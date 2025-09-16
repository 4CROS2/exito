import 'package:exito/src/features/cart/data/model/cart_item_model.dart';

abstract interface class CartDatasource {
  Future<void> addToCart({required CartItemModel item});
  Future<void> removeFromCart({required String id});
  Future<List<Map<String, dynamic>>> getCartItems();
  Future<void> updateCartItem({required CartItemModel item});
}
