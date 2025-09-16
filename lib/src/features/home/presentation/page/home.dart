import 'package:exito/src/core/app/presentation/bloc/app_provider.dart';
import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/home/domain/entity/category_entity.dart';
import 'package:exito/src/features/home/presentation/bloc/home_provider.dart';
import 'package:exito/src/features/home/presentation/widgets/category_tile.dart';
import 'package:exito/src/injection/container_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

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
          return Scaffold(
            appBar: AppBar(
              title: const Text('éxito'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.sunny),
                  onPressed: () {
                    context.read<AppProvider>().toggleTheme();
                  },
                ),
              ],
            ),
            body: switch (homeProvider.status) {
              Status.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              Status.success => _CategoryGrid(
                categories: homeProvider.categories,
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

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.categories});
  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: Constants.contentPadding,
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: Constants.mainPaddingValue,
        crossAxisSpacing: Constants.mainPaddingValue,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CategoryTile(
          index: index,
          title: categories[index].name.capitalize(),
          imageUrl: categories[index].imageUrl,
        );
      },
    );
  }
}
