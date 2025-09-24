import 'package:exito/src/features/cart/data/model/cart_item_model.dart';
import 'package:exito/src/features/cart/domain/datasource/cart_datasource.dart';
import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/domain/entity/cart_list_getter.dart';
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
  Future<void> addToExpressCart({required CartItemEntity item}) async {
    final CartItemModel model = CartItemModel.fromEntity(item);
    await _datasource.addToExpressCart(item: model);
  }

  @override
  Future<void> removeFromCart({required int id}) async {
    await _datasource.removeFromCart(id: id);
  }

  @override
  Future<CartListsGetter> getCartItems() async {
    final List<List<Map<String, dynamic>>> response = await Future.wait(
      <Future<List<Map<String, dynamic>>>>[
        _datasource.getCartItems(),
        _datasource.getExpressCartItems(),
      ],
    );
    return (
      cart: response[0]
          .map(
            (Map<String, dynamic> item) => CartItemModel.fromJson(json: item),
          )
          .toList(),
      express: response[1]
          .map(
            (Map<String, dynamic> item) => CartItemModel.fromJson(json: item),
          )
          .toList(),
    );
  }

  @override
  Future<void> removeFromExpressCart({required int id}) async {
    await _datasource.removeFromExpressCart(id: id);
  }

  @override
  Future<void> updateExpressCart({required CartItemEntity item}) {
    final CartItemModel model = CartItemModel.fromEntity(item);
    return _datasource.updateExpressCart(item: model);
  }

  @override
  Future<void> updateCartItem({required CartItemEntity item}) async {
    final CartItemModel model = CartItemModel.fromEntity(item);
    await _datasource.updateCartItem(item: model);
  }

  @override
  Future<List<CartItemModel>> getExpressCartItems() async {
    final List<Map<String, dynamic>> cartItems = await _datasource
        .getExpressCartItems();
    return cartItems
        .map((Map<String, dynamic> item) => CartItemModel.fromJson(json: item))
        .toList();
  }
  
  
}
