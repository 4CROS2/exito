import 'package:exito/src/features/cart/data/model/cart_item_model.dart';

/// Contrato para la fuente de datos del carrito de compras.
abstract interface class CartDatasource {
  /// Agrega un producto al carrito en la fuente de datos.
  Future<void> addToCart({required CartItemModel item});

  /// Elimina un producto del carrito por su ID en la fuente de datos.
  Future<void> removeFromCart({required String id});

  /// Obtiene todos los productos del carrito en formato mapa.
  Future<List<Map<String, dynamic>>> getCartItems();

  /// Actualiza un producto existente en el carrito en la fuente de datos.
  Future<void> updateCartItem({required CartItemModel item});
}
