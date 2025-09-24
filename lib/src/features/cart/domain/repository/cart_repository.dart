import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/domain/entity/cart_list_getter.dart';

/// Contrato del repositorio para la gestión del carrito de compras.
///
/// Define las operaciones CRUD sobre los items del carrito.
abstract interface class CartRepository {
  /// Obtiene todos los productos en el carrito.
  Future<CartListsGetter> getCartItems();

  /// Agrega un producto al carrito.
  Future<void> addToCart({required CartItemEntity item});

  /// Elimina un producto del carrito por su ID.
  Future<void> removeFromCart({required int id});

  /// Actualiza un producto existente en el carrito.
  Future<void> updateCartItem({required CartItemEntity item});

  Future<List<CartItemEntity>> getExpressCartItems();

  Future<void> addToExpressCart({required CartItemEntity item});

  Future<void> removeFromExpressCart({required int id});

  Future<void> updateExpressCart({required CartItemEntity item}) async {}
}
