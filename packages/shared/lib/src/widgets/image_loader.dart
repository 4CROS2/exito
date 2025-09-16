import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/src/extensions/theme_extension.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoader extends StatefulWidget {
  const ImageLoader({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.animationDuration = const Duration(milliseconds: 450),
    this.borderRadius = BorderRadius.zero,
    super.key,
  });
  final String imageUrl;
  final BoxFit? fit;
  final Duration animationDuration;
  final BorderRadius borderRadius;

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: CachedNetworkImage(
        fit: widget.fit,
        progressIndicatorBuilder: (_, _, _) {
          return Shimmer.fromColors(
            baseColor: context.tertiaryColor,
            highlightColor: context.tertiaryColor.withValues(alpha: .5),
            period: widget.animationDuration,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.tertiaryColor,
                borderRadius: widget.borderRadius,
              ),
              child: SizedBox.fromSize(size: Size.infinite),
            ),
          );
        },

        errorWidget: (BuildContext context, String url, Object error) {
          return const Icon(Icons.error);
        },
        imageUrl: widget.imageUrl,
      ),
    );
  }
}
