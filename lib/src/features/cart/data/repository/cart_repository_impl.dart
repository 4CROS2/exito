import 'package:exito/src/features/cart/data/model/cart_item_mode.dart';
import 'package:exito/src/features/cart/domain/datasource/cart_datasource.dart';
import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/domain/repository/cart_repository.dart';

class ICartRepository implements CartRepository {
  ICartRepository({required CartDatasource datasource})
    : _datasource = datasource;
  final CartDatasource _datasource;
  @override
  Future<void> addToCart({required CartItemEntity item}) async {
    final CartItemModel model = CartItemModel.fromEntity(item);
    await _datasource.addToCart(item: model);
  }

  @override
  Future<void> removeFromCart({required String id}) async {
    await _datasource.removeFromCart(id: id);
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final List<Map<String, dynamic>> cartItems = await _datasource
        .getCartItems();
    return cartItems
        .map((Map<String, dynamic> item) => CartItemModel.fromJson(item))
        .toList();
  }
}
