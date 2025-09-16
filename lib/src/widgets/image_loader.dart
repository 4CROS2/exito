import 'package:cached_network_image/cached_network_image.dart';
import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/core/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoader extends StatefulWidget {
  const ImageLoader({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    super.key,
  });
  final String imageUrl;
  final BoxFit? fit;

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: widget.fit,
      progressIndicatorBuilder: (_, _, _) {
        return Shimmer.fromColors(
          baseColor: context.tertiaryColor,
          highlightColor: context.tertiaryColor.withValues(alpha: .5),
          period: Constants.animationDuration * 4,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.tertiaryColor,
              borderRadius: Constants.mainBorderRadius,
            ),
            child: SizedBox.fromSize(size: Size.infinite),
          ),
        );
      },

      errorWidget: (BuildContext context, String url, Object error) {
        return const Icon(Icons.error);
      },
      imageUrl: widget.imageUrl,
    );
  }
}
