import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/domain/repository/cart_repository.dart';

class CartUseCase {
  CartUseCase({required CartRepository repository}) : _repository = repository;
  final CartRepository _repository;

  Future<void> addToCart({required CartItemEntity item}) async {
    await _repository.addToCart(item: item);
  }

  Future<void> removeFromCart({required String id}) async {
    await _repository.removeFromCart(id: id);
  }

  Future<List<CartItemEntity>> getCartItems() async {
    return await _repository.getCartItems();
  }
}
