import 'package:flutter/material.dart';
import 'package:shared/widgets.dart';

/// Widget genérico para construir una grilla de elementos con animación y refresco
/// Uso: GridBuilder<[T]>(
///       items: productList,
///      builder: (context, index, item) => ProductTile(product: item),
///    onRefresh: () async { ... },
///    )
/// [T] es el tipo de los elementos en la lista
/// [items] es la lista de elementos a mostrar
/// [builder] es la función que construye cada elemento de la grilla
/// [onRefresh] es la función que se llama al hacer pull to refresh
/// [mainAxisSpacing] es el espacio vertical entre elementos
/// [crossAxisSpacing] es el espacio horizontal entre elementos
/// [aspectRatio] es la relación de aspecto de cada elemento (ancho/alto)
/// [animationDuration] es la duración de la animación de aparición
/// [contentPadding] es el padding alrededor de la grilla
///
class GridBuilder<T> extends StatelessWidget {
  const GridBuilder({
    required this.items,
    required this.builder,
    required this.onRefresh,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.aspectRatio = 1,
    this.animationDuration = const Duration(milliseconds: 300),
    this.contentPadding = EdgeInsets.zero,
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
