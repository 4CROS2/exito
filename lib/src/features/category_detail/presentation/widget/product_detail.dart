import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/cart/presentation/bloc/cart_provider.dart';
import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:exito/src/features/category_detail/presentation/widget/first_buttons.dart';
import 'package:exito/src/features/category_detail/presentation/widget/secondary_buttons.dart';
import 'package:exito/src/features/express_mode/presentation/bloc/express_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';
import 'package:shared/widgets.dart';

class ProductTile extends StatefulWidget {
  const ProductTile({required this.product, super.key});
  final ProductEntity product;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Constants.mainBorderRadius,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.tertiaryColor),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      Colors.black26,
                      Colors.black87,
                      Colors.black,
                    ],
                    stops: <double>[0.0, 0.2, 0.8, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.darken,
                child: ImageLoader(imageUrl: widget.product.imageUrl),
              ),
            ),
            Positioned(
              bottom: Constants.mainPaddingValue,
              left: Constants.mainPaddingValue,
              right: Constants.mainPaddingValue,
              child: Builder(
                builder: (BuildContext context) {
                  final CartProvider cartProvider = context
                      .watch<CartProvider>();
                  final bool isInCart = cartProvider.cartItems.any(
                    (ProductEntity p) => p.id == widget.product.id,
                  );
                  final bool isExpressMode = cartProvider.expressCartItems.any(
                    (ProductEntity p) => p.id == widget.product.id,
                  );

                  final int quantity = isInCart
                      ? cartProvider.cartItems
                            .firstWhere(
                              (ProductEntity p) => p.id == widget.product.id,
                            )
                            .quantity
                      : 0;

                  final int expressQuantity = isExpressMode
                      ? cartProvider.expressCartItems
                            .firstWhere(
                              (ProductEntity p) => p.id == widget.product.id,
                            )
                            .quantity
                      : 0;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: Constants.mainPaddingValue / 2,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          RatingBar.readOnly(
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            size: 16,
                            maxRating: 5,
                            initialRating: widget.product.rating.rate,
                          ),
                          Text(
                            ' (${widget.product.rating.count})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.product.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          height: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.product.price.toCurrency(),
                        style: const TextStyle(
                          color: Constants.primaryLightColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Selector<ExpressModeProvider, bool>(
                        selector:
                            (
                              BuildContext context,
                              ExpressModeProvider provider,
                            ) => provider.isExpressMode,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                              return AnimatedSwitcher(
                                duration: Constants.animationDuration,
                                layoutBuilder:
                                    (
                                      Widget? currentChild,
                                      List<Widget> previousChildren,
                                    ) {
                                      return Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: <Widget>[
                                          ...previousChildren,
                                          if (currentChild != null)
                                            currentChild,
                                        ],
                                      );
                                    },
                                transitionBuilder:
                                    (
                                      Widget child,
                                      Animation<double> animation,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                child: switch (value) {
                                  true => SecondaryButton(
                                    quantity: expressQuantity,
                                    cartProvider: cartProvider,
                                    product: widget.product,
                                  ),
                                  false => FistButtons(
                                    isInCart: isInCart,
                                    quantity: quantity,
                                    cartProvider: cartProvider,
                                    widget: widget,
                                  ),
                                },
                              );
                            },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
