import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/domain/entity/cart_list_getter.dart';
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
      final CartListsGetter items = await _cartUseCase.getCartItems();

      _cartItems.addAll(items.cart);
      _expressCartItems.addAll(items.express);
      _getCartItemsStatus = Status.success;
      notifyListeners();
    } catch (e) {
      _getCartItemsStatus = Status.error;
      notifyListeners();
    }
  }

  /// ➕ Agrega un producto (cantidad = 1).
  Future<void> addItemToCart({required ProductEntity item}) async {
    try {
      final CartItemEntity product = CartItemEntity.fromProductEntity(
        product: item,
        quantity: 1,
      );

      _addToCartStatus = Status.loading;
      notifyListeners();

      _cartItems.add(product);
      await _cartUseCase.addItemToCart(item: product);
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
  Future<void> removeItem({required ProductEntity item}) async {
    await updateItemQuantity(item: item, quantity: 0);
  }

  /// 🔄 Actualiza cantidad en carrito
  Future<void> updateItemQuantity({
    required ProductEntity item,
    required int quantity,
  }) async {
    try {
      final CartItemEntity product = CartItemEntity.fromProductEntity(
        product: item,
        quantity: quantity,
      );
      _updateItemStatus = Status.loading;
      notifyListeners();

      final int index = _cartItems.indexWhere(
        (CartItemEntity p) => p.id == item.id,
      );

      if (index != -1) {
        if (quantity == 0) {
          _cartItems.removeAt(index);
          await _cartUseCase.removeFromCart(id: item.id);
        } else {
          _cartItems[index] = product;
          await _cartUseCase.updateCartItem(item: product);
        }
      } else {
        if (quantity > 0) {
          _cartItems.add(product);
          await _cartUseCase.updateCartItem(item: product);
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

  /// Actualiza cantidad en carrito en modo exprés
  Future<void> addAndUpdateExpressItemQuantity({
    required ProductEntity item,
    required int quantity,
  }) async {
    try {
      final CartItemEntity product = CartItemEntity.fromProductEntity(
        product: item,
        quantity: quantity,
      );
      _updateItemStatus = Status.loading;
      notifyListeners();

      final int index = _expressCartItems.indexWhere(
        (CartItemEntity p) => p.id == item.id,
      );

      if (index != -1) {
        if (quantity == 0) {
          _expressCartItems.removeAt(index);
          await _cartUseCase.removeFromExpressCart(id: item.id);
        } else {
          _expressCartItems[index] = product;
          await _cartUseCase.updateExpressCart(item: product);
        }
      } else {
        if (quantity > 0) {
          _expressCartItems.add(product);
          await _cartUseCase.addToExpressCart(item: product);
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

  /// 🧹 Limpia el carrito exprés (cuando sale del modo exprés)
  void clearExpressCart() {
    _expressCartItems.clear();
    notifyListeners();
  }
}
