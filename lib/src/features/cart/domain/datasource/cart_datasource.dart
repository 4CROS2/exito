import 'package:exito/src/features/cart/data/model/cart_item_model.dart';

/// Contrato para la fuente de datos del carrito de compras.
abstract interface class CartDatasource {
  /// Obtiene todos los productos del carrito en formato mapa.
  Future<List<Map<String, dynamic>>> getCartItems();

  /// Agrega un producto al carrito en la fuente de datos.
  Future<void> addToCart({required CartItemModel item});

  /// Elimina un producto del carrito por su ID en la fuente de datos.
  Future<void> removeFromCart({required int id});

  /// Actualiza un producto existente en el carrito en la fuente de datos.
  Future<void> updateCartItem({required CartItemModel item});

  /// Obtiene todos los productos del carrito exprés en formato mapa.
  Future<List<Map<String, dynamic>>> getExpressCartItems();

  /// Agrega un producto al carrito exprés en la fuente de datos.
  Future<void> addToExpressCart({required CartItemModel item});

  /// Elimina un producto del carrito exprés por su ID en la fuente de datos.
  Future<void> removeFromExpressCart({required int id});

  /// Actualiza un producto existente en el carrito exprés en la fuente de datos.
  Future<void> updateExpressCart({required CartItemModel item});
}
