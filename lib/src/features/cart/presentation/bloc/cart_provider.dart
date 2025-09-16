import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/domain/usecase/cart_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CartProvider extends ChangeNotifier {
  CartProvider({required CartUseCase cartUseCase})
    : _cartUseCase = cartUseCase,
      _cartItems = <CartItemEntity>[];

  final CartUseCase _cartUseCase;

  Status _addToCartStatus = Status.initial;
  Status _getCartItemsStatus = Status.initial;
  final String _message = '';
  final List<CartItemEntity> _cartItems;

  List<CartItemEntity> get cartItems => _cartItems;
  int get itemCount => _cartItems.length;
  Status get addToCartStatus => _addToCartStatus;
  Status get getCartItemsStatus => _getCartItemsStatus;
  String get message => _message;

  void addItem({required CartItemEntity item}) async {
    try {
      _addToCartStatus = Status.loading;
      await _cartUseCase.addToCart(item: item);
      _cartItems.add(item);
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

  void getCartItems() async {
    try {
      _getCartItemsStatus = Status.loading;
      final List<CartItemEntity> items = await _cartUseCase.getCartItems();
      _cartItems.clear();
      _cartItems.addAll(items);
      _getCartItemsStatus = Status.success;
      notifyListeners();
    } catch (e) {
      _getCartItemsStatus = Status.error;
      notifyListeners();
    }
  }
}
