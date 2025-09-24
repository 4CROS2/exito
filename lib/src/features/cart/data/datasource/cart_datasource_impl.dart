import 'dart:convert';

import 'package:exito/src/features/cart/data/model/cart_item_model.dart';
import 'package:exito/src/features/cart/domain/datasource/cart_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ICartDatasource implements CartDatasource {
  static const String _cartKey = 'cart_items';

  /// Obtiene la instancia de SharedPreferences
  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  /// Agrega un item al carrito
  /// [item] El item a agregar

  @override
  Future<void> addToCart({required CartItemModel item}) async {
    final SharedPreferences prefs = await _prefs;
    final String? cartJson = prefs.getString(_cartKey);

    List<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[];

    if (cartJson != null) {
      cartItems = List<Map<String, dynamic>>.from(jsonDecode(cartJson));
    }

    cartItems.add(item.toJson());

    await prefs.setString(_cartKey, jsonEncode(cartItems));
  }

  @override
  Future<void> addToExpressCart({required CartItemModel item}) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? cartJson = prefs.getString('express_$_cartKey');

      List<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[];

      if (cartJson != null) {
        cartItems = List<Map<String, dynamic>>.from(jsonDecode(cartJson));
      }

      cartItems.add(item.toJson());

      await prefs.setString('express_$_cartKey', jsonEncode(cartItems));
    } catch (e) {
      throw Exception('Error al agregar al carrito express: $e');
    }
  }

  /// Elimina un item del carrito
  /// [id] El id del item a eliminar
  @override
  Future<void> removeFromCart({required int id}) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? cartJson = prefs.getString(_cartKey);

      if (cartJson == null) {
        return;
      }
      List<Map<String, dynamic>> cartItems = List<Map<String, dynamic>>.from(
        jsonDecode(cartJson),
      );

      cartItems.removeWhere((Map<String, dynamic> item) => item['id'] == id);
      await prefs.setString(_cartKey, jsonEncode(cartItems));
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene todos los items del carrito
  @override
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final SharedPreferences prefs = await _prefs;
    final String? cartJson = prefs.getString(_cartKey);

    if (cartJson == null) {
      return <Map<String, dynamic>>[];
    }

    return List<Map<String, dynamic>>.from(jsonDecode(cartJson));
  }

  @override
  Future<void> updateCartItem({required CartItemModel item}) async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? cartJson = prefs.getString(_cartKey);

      if (cartJson == null) {
        return;
      }

      List<Map<String, dynamic>> cartItems = List<Map<String, dynamic>>.from(
        jsonDecode(cartJson),
      );
      final int index = cartItems.indexWhere(
        (Map<String, dynamic> p) => p['id'] == item.id,
      );

      cartItems[index] = item.toJson();

      await prefs.setString(_cartKey, jsonEncode(cartItems));
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene todos los items del carrito express
  @override
  Future<List<Map<String, dynamic>>> getExpressCartItems() async {
    try {
      final SharedPreferences prefs = await _prefs;
      final String? cartJson = prefs.getString('express_$_cartKey');
      if (cartJson == null) {
        return <Map<String, dynamic>>[];
      }

      return List<Map<String, dynamic>>.from(jsonDecode(cartJson));
    } catch (e) {
      rethrow;
    }
  }
}
