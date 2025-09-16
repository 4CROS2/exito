import 'package:flutter/material.dart';
import 'package:shared/widgets.dart';

class GridBuilder<T> extends StatelessWidget {
  const GridBuilder({
    required this.items,
    required this.builder,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.aspectRatio = 1,
    this.animationDuration = const Duration(milliseconds: 300),
    this.contentPadding = EdgeInsets.zero,
    required this.onRefresh,
    super.key,
  });
  final List<T> items;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final Duration animationDuration;
  final EdgeInsets contentPadding;
  final double aspectRatio;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext context, int index, T item) builder;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: contentPadding,
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: aspectRatio,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        ),
        itemBuilder: (BuildContext context, int index) {
          return FadeWidget(
            index: index,
            animationDuration: animationDuration,
            child: builder(context, index, items[index]),
          );
        },
      ),
    );
  }
}
