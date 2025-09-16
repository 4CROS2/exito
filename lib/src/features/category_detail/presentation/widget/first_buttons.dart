import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/cart/presentation/bloc/cart_provider.dart';
import 'package:exito/src/features/category_detail/presentation/widget/product_button.dart';
import 'package:exito/src/features/category_detail/presentation/widget/product_detail.dart';
import 'package:exito/src/features/category_detail/presentation/widget/product_quatity_button.dart';
import 'package:flutter/material.dart';

class FistButtons extends StatelessWidget {
  const FistButtons({
    required this.isInCart,
    required this.quantity,
    required this.cartProvider,
    required this.widget,
    super.key,
  });

  final bool isInCart;
  final int quantity;
  final CartProvider cartProvider;
  final ProductTile widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Constants.animationDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: switch (isInCart) {
        true => ProductQuantityButton(
          quantity: quantity,
          onAdd: () {
            cartProvider.updateItemQuantity(
              item: widget.product,
              quantity: quantity + 1,
            );
          },
          onRemove: () {
            cartProvider.updateItemQuantity(
              item: widget.product,
              quantity: quantity - 1,
            );
          },
        ),
        false => ProductButton(
          label: 'Agregar',
          onTap: () {
            cartProvider.addItem(item: widget.product);
          },
        ),
      },
    );
  }
}
