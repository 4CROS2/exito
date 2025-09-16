import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/presentation/bloc/cart_provider.dart';
import 'package:exito/src/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  TextStyle get _textStyle =>
      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final CartProvider cartProvider = context.watch<CartProvider>();
        final double totalPrice = cartProvider.cartItems.fold(
          0,
          (double sum, CartItemEntity item) => sum + item.price * item.quantity,
        );
        return Scaffold(
          appBar: AppBar(title: const Text('Carrito de Compras')),
          body: ListView.builder(
            padding: Constants.contentPadding,
            itemCount: cartProvider.itemCount,
            itemBuilder: (BuildContext context, int index) {
              return CartItemTile(item: cartProvider.cartItems[index]);
            },
          ),
          bottomNavigationBar: SizedBox.fromSize(
            size: const Size(double.infinity, 100),
            child: DecoratedBox(
              decoration: BoxDecoration(color: context.primaryColor),
              child: SafeArea(
                child: Padding(
                  padding: Constants.contentPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total', style: _textStyle),
                      Text(totalPrice.toString().toCurrency(), style: _textStyle),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
