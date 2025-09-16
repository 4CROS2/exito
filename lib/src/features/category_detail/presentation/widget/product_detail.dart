import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:flutter/material.dart';
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  //use intl package to format price
                  Text(
                    widget.product.price.toString(),
                    style: const TextStyle(
                      color: Constants.primaryLightColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
