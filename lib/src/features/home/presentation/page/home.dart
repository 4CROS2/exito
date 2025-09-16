import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/cart/presentation/bloc/cart_provider.dart';
import 'package:exito/src/features/home/domain/entity/category_entity.dart';
import 'package:exito/src/features/home/presentation/bloc/home_provider.dart';
import 'package:exito/src/features/home/presentation/widgets/category_tile.dart';
import 'package:exito/src/injection/container_injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';
import 'package:shared/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext context) => sl<HomeProvider>()..getCategories(),
      child: Builder(
        builder: (BuildContext context) {
          final HomeProvider homeProvider = context.watch<HomeProvider>();
          final CartProvider cartProvider = context.watch<CartProvider>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('éxito'),
              centerTitle: true,
              actions: <Widget>[
                CartButton(
                  onTap: () {
                    context.push('/cart');
                  },
                  itemCount: cartProvider.itemCount,
                ),
              ],
            ),
            body: switch (homeProvider.status) {
              Status.loading => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              Status.success => GridBuilder<CategoryEntity>(
                items: homeProvider.categories,
                animationDuration: Constants.animationDuration,
                contentPadding: Constants.contentPadding,
                crossAxisSpacing: Constants.mainPaddingValue,
                mainAxisSpacing: Constants.mainPaddingValue,
                onRefresh: () async => homeProvider.getCategories(),
                builder:
                    (BuildContext context, int index, CategoryEntity item) {
                      return CategoryTile(
                        onTap: () {
                          context.push('/categoryDetail/${item.categoryName}');
                        },
                        title: item.categoryName.capitalize(),
                        imageUrl: item.imageUrl,
                      );
                    },
              ),
              Status.error => Center(child: Text(homeProvider.errorMessage)),
              _ => const SizedBox.shrink(),
            },
          );
        },
      ),
    );
  }
}
