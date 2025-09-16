import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/domain/usecase/cart_usecase.dart';
import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

/// Provider para la gestión del estado del carrito de compras.
///
/// Expone métodos para agregar, eliminar y actualizar productos, y notifica cambios a la UI.
class CartProvider extends ChangeNotifier {
  CartProvider({required CartUseCase cartUseCase})
    : _cartUseCase = cartUseCase,
      _cartItems = <CartItemEntity>[],
      _expressCartItems = <CartItemEntity>[];

  final CartUseCase _cartUseCase;

  Status _addToCartStatus = Status.initial;
  Status _getCartItemsStatus = Status.initial;
  Status _updateItemStatus = Status.initial;
  final String _message = '';

  final List<CartItemEntity> _cartItems;
  final List<CartItemEntity> _expressCartItems;

  List<CartItemEntity> get cartItems => _cartItems;
  List<CartItemEntity> get expressCartItems => _expressCartItems;
  int get itemCount => _cartItems.length;
  int get expressItemCount => _expressCartItems.length;
  Status get addToCartStatus => _addToCartStatus;
  Status get getCartItemsStatus => _getCartItemsStatus;
  String get message => _message;
  Status get updateItemStatus => _updateItemStatus;

  Future<void> getCartItems() async {
    try {
      _getCartItemsStatus = Status.loading;
      final (List<CartItemEntity>, List<CartItemEntity>) items =
          await _cartUseCase.getCartItems();

      _cartItems
        ..clear()
        ..addAll(items.$1);
      _expressCartItems
        ..clear()
        ..addAll(items.$2);
      _getCartItemsStatus = Status.success;
      notifyListeners();
    } catch (e) {
      _getCartItemsStatus = Status.error;
      notifyListeners();
    }
  }

  /// ➕ Agrega un producto (normal o exprés)
  Future<void> addItem({
    required ProductEntity item,
    bool isExpress = false,
  }) async {
    if (isExpress) {
      // 👉 exprés: solo en memoria
      final int index = _expressCartItems.indexWhere(
        (CartItemEntity p) => p.id == item.id,
      );
      if (index != -1) {
        _expressCartItems[index] = CartItemEntity.fromProductEntity(
          item,
          _expressCartItems[index].quantity + 1,
        );
      } else {
        _expressCartItems.add(CartItemEntity.fromProductEntity(item, 1));
      }
      notifyListeners();
      return;
    }

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

  /// ❌ Elimina un producto (cantidad = 0).
  Future<void> removeItem({
    required ProductEntity item,
    required bool isExpress,
  }) async {
    await updateItemQuantity(item: item, quantity: 0, isExpress: isExpress);
  }

  /// 🔄 Actualiza cantidad en carrito (normal o exprés).
  Future<void> updateItemQuantity({
    required ProductEntity item,
    required int quantity,
    bool isExpress = false,
  }) async {
    if (isExpress) {
      final int index = _expressCartItems.indexWhere(
        (CartItemEntity p) => p.id == item.id,
      );

      if (index != -1) {
        if (quantity == 0) {
          _expressCartItems.removeAt(index);
        } else {
          _expressCartItems[index] = CartItemEntity.fromProductEntity(
            item,
            quantity,
          );
        }
      } else {
        if (quantity > 0) {
          _expressCartItems.add(
            CartItemEntity.fromProductEntity(item, quantity),
          );
        }
      }
      notifyListeners();
      return;
    }

    try {
      _updateItemStatus = Status.loading;
      notifyListeners();

      await _cartUseCase.updateCartItem(
        isExpress: isExpress,
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

  /// 🧹 Limpia el carrito exprés (cuando sales de modo exprés)
  void clearExpressCart() {
    _expressCartItems.clear();
    notifyListeners();
  }
}
