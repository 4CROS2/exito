import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/cart/presentation/bloc/cart_provider.dart';
import 'package:exito/src/features/category_detail/presentation/widget/product_quatity_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';
import 'package:shared/widgets.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile({required this.item, super.key});
  final CartItemEntity item;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.mainPaddingValue),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: Constants.mainBorderRadius,
          color: context.tertiaryColor,
        ),
        child: ClipRRect(
          borderRadius: Constants.mainBorderRadius,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: Constants.mainPaddingAll,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Constants.mainPaddingValue,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox.fromSize(
                      size: const Size(150, 100),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: Constants.innerBorderRadius,
                          color: context.secondaryColor,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .1),
                              blurRadius: 10,
                              offset: Offset.zero,
                            ),
                          ],
                        ),
                        child: ImageLoader(
                          imageUrl: widget.item.imageUrl,
                          borderRadius: Constants.innerBorderRadius,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: Constants.mainPaddingValue,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.item.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: widget.item.price.toString().toCurrency(),
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    ' x${widget.item.quantity} = ${(widget.item.price * widget.item.quantity).toString().toCurrency()}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                            color: Constants.secondaryDarkColor,
                            height: 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Builder(
                          builder: (BuildContext context) {
                            final CartProvider cartProvider = context
                                .read<CartProvider>();
                            return ProductQuantityButton(
                              quantity: widget.item.quantity,
                              onAdd: () {
                                cartProvider.updateItemQuantity(
                                  item: widget.item,
                                  quantity: widget.item.quantity + 1,
                                );
                              },
                              onRemove: () {
                                cartProvider.updateItemQuantity(
                                  item: widget.item,
                                  quantity: widget.item.quantity - 1,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
