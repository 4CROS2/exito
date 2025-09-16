import 'package:exito/src/core/app/presentation/bloc/app_provider.dart';
import 'package:exito/src/core/constants/constants.dart';
import 'package:exito/src/features/home/presentation/bloc/home_provider.dart';
import 'package:exito/src/features/home/presentation/widgets/category_tile.dart';
import 'package:exito/src/injection/container_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext context) => sl<HomeProvider>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exito'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.sunny),
              onPressed: () {
                context.read<AppProvider>().toggleTheme();
              },
            ),
          ],
        ),
        body: GridView.builder(
          padding: Constants.contentPadding,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: Constants.mainPaddingValue,
            crossAxisSpacing: Constants.mainPaddingValue,
          ),
          itemBuilder: (BuildContext context, int index) {
            return CategoryTile(index: index);
          },
        ),
      ),
    );
  }
}
