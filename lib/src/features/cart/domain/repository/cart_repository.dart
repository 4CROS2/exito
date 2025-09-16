import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';

abstract interface class CartRepository {
  Future<void> addToCart({required CartItemEntity item});
  Future<void> removeFromCart({required String id});
  Future<List<CartItemEntity>> getCartItems();
}
