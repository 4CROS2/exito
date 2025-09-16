import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/presentation/bloc/cart_provider.dart';
import 'package:exito/src/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:exito/src/features/express_mode/presentation/bloc/express_mode_provider.dart';
import 'package:exito/src/features/express_mode/presentation/page/express_mode_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  TextStyle get _textStyle =>
      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final ExpressModeProvider expressModeProvider = context
        .watch<ExpressModeProvider>();
    final CartProvider cartProvider = context.watch<CartProvider>();

    // 🔹 Selecciona el carrito activo según el modo exprés
    final List<CartItemEntity> activeCartItems =
        expressModeProvider.isExpressMode
        ? cartProvider.expressCartItems
        : cartProvider.cartItems;

    final bool isEmpty = activeCartItems.isEmpty;

    // 🔹 Calcula total solo sobre el carrito normal (persistente)
    final double totalPrice = cartProvider.cartItems.fold(
      0,
      (double sum, CartItemEntity item) => sum + item.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        actions: const <Widget>[ExpressModeSwitch()],
        centerTitle: false,
      ),
      body: isEmpty
          ? const Center(
              child: Text(
                'No hay items en el carrito',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: Constants.contentPadding,
              itemCount: activeCartItems.length,
              itemBuilder: (BuildContext context, int index) {
                final CartItemEntity item = activeCartItems[index];
                return CartItemTile(item: item);
              },
            ),
      bottomNavigationBar: isEmpty
          ? null
          : SizedBox(
              height: 100,
              child: DecoratedBox(
                decoration: BoxDecoration(color: context.primaryColor),
                child: SafeArea(
                  child: Padding(
                    padding: Constants.contentPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total', style: _textStyle),
                        Text(totalPrice.toCurrency(), style: _textStyle),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
