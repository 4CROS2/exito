import 'dart:convert';

import 'package:exito/src/features/cart/data/model/cart_item_mode.dart';
import 'package:exito/src/features/cart/domain/datasource/cart_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ICartDatasource implements CartDatasource {
  static const String _cartKey = 'cart_items';

  /// Obtiene la instancia de SharedPreferences
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

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
  Future<void> removeFromCart({required String id}) async {
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
  }

  @override
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final SharedPreferences prefs = await _prefs;
    final String? cartJson = prefs.getString(_cartKey);

    if (cartJson == null) {
      return <Map<String, dynamic>>[];
    }

    return List<Map<String, dynamic>>.from(jsonDecode(cartJson));
  }
}
