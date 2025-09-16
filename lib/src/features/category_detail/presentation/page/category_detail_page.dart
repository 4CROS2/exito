import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:exito/src/features/category_detail/presentation/bloc/category_detail_provider.dart';
import 'package:exito/src/features/category_detail/presentation/widget/product_detail.dart';
import 'package:exito/src/injection/container_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';
import 'package:shared/widgets.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({required this.categoryFilter, super.key});
  final String categoryFilter;

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryDetailProvider>(
      create: (BuildContext context) =>
          sl<CategoryDetailProvider>()
            ..loadProductsByCategory(category: widget.categoryFilter),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryFilter.capitalize()),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Badge.count(
                count: 2,
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ],
        ),
        body: Builder(
          builder: (BuildContext context) {
            final CategoryDetailProvider provider = context
                .watch<CategoryDetailProvider>();
            if (provider.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.status == Status.error) {
              return Center(child: Text(provider.message));
            }
            final List<ProductEntity> products = provider.products;
            return GridBuilder<ProductEntity>(
              onRefresh: () async => provider.loadProductsByCategory(
                category: widget.categoryFilter,
              ),
              crossAxisSpacing: Constants.mainPaddingValue,
              mainAxisSpacing: Constants.mainPaddingValue,
              animationDuration: Constants.animationDuration,
              contentPadding: Constants.contentPadding,
              aspectRatio: 1 / 1.5,
              items: products,
              builder: (BuildContext context, int index, ProductEntity item) {
                return ProductTile(product: item);
              },
            );
          },
        ),
      ),
    );
  }
}
