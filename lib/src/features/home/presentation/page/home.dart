import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/cart/presentation/bloc/cart_provider.dart';
import 'package:exito/src/features/express_mode/presentation/page/express_mode_switch.dart';
import 'package:exito/src/features/home/domain/entity/category_entity.dart';
import 'package:exito/src/features/home/presentation/bloc/home_provider.dart';
import 'package:exito/src/features/home/presentation/widgets/category_tile.dart';
import 'package:exito/src/injection/container_injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';
import 'package:shared/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => sl<HomeProvider>()..getCategories(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: _HomeAppBar(), body: _HomeBody());
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('éxito'),
      centerTitle: false,
      actions: <Widget>[
        const ExpressModeSwitch(),
        Selector<CartProvider, int>(
          selector: (_, CartProvider cart) => cart.itemCount,
          builder: (_, int itemCount, _) {
            return CartButton(
              onTap: () => context.push('/cart'),
              itemCount: itemCount,
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = context.watch<HomeProvider>();

    return switch (homeProvider.status) {
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
        builder: (BuildContext context, int index, CategoryEntity item) {
          return CategoryTile(
            onTap: () => context.push('/categoryDetail/${item.categoryName}'),
            title: item.categoryName.capitalize(),
            imageUrl: item.imageUrl,
          );
        },
      ),
      Status.error => Center(child: Text(homeProvider.errorMessage)),
      _ => const SizedBox.shrink(),
    };
  }
}
