import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:flutter/material.dart';
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
            height: 200,
            width: double.infinity,
            child: Padding(
              padding: Constants.mainPaddingAll,
              child: Row(
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
                        Text(
                          widget.item.price.toString().toCurrency(),
                          style: const TextStyle(
                            fontSize: 24,
                            color: Constants.secondaryDarkColor,
                            height: 1.2,
                            fontWeight: FontWeight.bold,
                          ),
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
