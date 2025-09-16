import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/domain/repository/cart_repository.dart';

/// Caso de uso principal para la gestión del carrito de compras.
///
/// Encapsula la lógica de negocio y delega en el repositorio correspondiente.
class CartUseCase {
  CartUseCase({required CartRepository repository}) : _repository = repository;
  final CartRepository _repository;

  /// Agrega un producto al carrito.
  Future<void> addToCart({required CartItemEntity item}) async {
    await _repository.addToCart(item: item);
  }

  /// Actualiza un producto existente en el carrito.
  Future<void> updateCartItem({required CartItemEntity item}) async {
    try {
      await _repository.updateCartItem(item: item);
    } catch (e) {
      rethrow;
    }
  }

  /// Elimina un producto del carrito por su ID.
  Future<void> removeFromCart({required String id}) async {
    await _repository.removeFromCart(id: id);
  }

  /// Obtiene la lista de productos en el carrito.
  Future<List<CartItemEntity>> getCartItems() async {
    return await _repository.getCartItems();
  }
}
