import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/domain/usecase/cart_usecase.dart';
import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CartProvider extends ChangeNotifier {
  CartProvider({required CartUseCase cartUseCase})
    : _cartUseCase = cartUseCase,
      _cartItems = <CartItemEntity>[];

  final CartUseCase _cartUseCase;

  Status _addToCartStatus = Status.initial;
  Status _getCartItemsStatus = Status.initial;
  Status _updateItemStatus = Status.initial;
  final String _message = '';
  final List<CartItemEntity> _cartItems;

  List<CartItemEntity> get cartItems => _cartItems;
  int get itemCount => _cartItems.length;
  Status get addToCartStatus => _addToCartStatus;
  Status get getCartItemsStatus => _getCartItemsStatus;
  String get message => _message;
  Status get updateItemStatus => _updateItemStatus;

  Future<void> getCartItems() async {
    try {
      _getCartItemsStatus = Status.loading;
      final List<CartItemEntity> items = await _cartUseCase.getCartItems();
      _cartItems
        ..clear()
        ..addAll(items);
      _getCartItemsStatus = Status.success;
      notifyListeners();
    } catch (e) {
      _getCartItemsStatus = Status.error;
      notifyListeners();
    }
  }

  Future<void> addItem({required ProductEntity item}) async {
    try {
      _addToCartStatus = Status.loading;
      notifyListeners();

      await _cartUseCase.addToCart(
        item: CartItemEntity.fromProductEntity(item, 1),
      );

      _cartItems.add(CartItemEntity.fromProductEntity(item, 1));

      _addToCartStatus = Status.success;
      notifyListeners();
    } catch (e) {
      _addToCartStatus = Status.error;
      notifyListeners();
    } finally {
      _addToCartStatus = Status.initial;
      notifyListeners();
    }
  }

  Future<void> removeItem({required ProductEntity item}) async {
    // 👇 Ahora delega en updateItemQuantity
    await updateItemQuantity(item: item, quantity: 0);
  }

  Future<void> updateItemQuantity({
    required ProductEntity item,
    required int quantity,
  }) async {
    try {
      _updateItemStatus = Status.loading;
      notifyListeners();

      await _cartUseCase.updateCartItem(
        item: CartItemEntity.fromProductEntity(item, quantity),
      );

      final int index = _cartItems.indexWhere(
        (CartItemEntity p) => p.id == item.id,
      );

      if (index != -1) {
        if (quantity == 0) {
          _cartItems.removeAt(index);
        } else {
          _cartItems[index] = CartItemEntity.fromProductEntity(item, quantity);
        }
      } else {
        // 👇 Edge case: si no existía en memoria, pero sí llega update
        if (quantity > 0) {
          _cartItems.add(CartItemEntity.fromProductEntity(item, quantity));
        }
      }

      _updateItemStatus = Status.success;
      notifyListeners();
    } catch (e) {
      _updateItemStatus = Status.error;
      notifyListeners();
    } finally {
      _updateItemStatus = Status.initial;
      notifyListeners();
    }
  }
}
