import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/cart/presentation/bloc/cart_provider.dart';
import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:exito/src/features/category_detail/presentation/widget/product_button.dart';
import 'package:exito/src/features/category_detail/presentation/widget/product_quatity_button.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.quantity,
    required this.cartProvider,
    required this.product,
    super.key,
  });
  final int quantity;
  final CartProvider cartProvider;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Column(
          spacing: Constants.mainPaddingValue,
          children: <Widget>[
            ProductButton(
              label: 'Comprar',
              suffixIcon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              onTap: () {},
              color: const Color(0xff229acb),
            ),
            ProductQuantityButton(
              prefixIcon: Icons.delete_outline_rounded,
              iconButtonColor: Colors.white,
              buttonColor: const Color(0xff229acb),
              quantity: quantity,
              onAdd: () {
                cartProvider.updateItemQuantity(
                  item: product,
                  quantity: quantity + 1,
                  isExpress: true,
                );
              },

              onRemove: () {
                cartProvider.removeItem(item: product, isExpress: true);
              },
            ),
          ],
        );
      },
    );
  }
}
