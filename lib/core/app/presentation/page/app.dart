import 'package:exito/core/extension/theme_extension.dart';
import 'package:exito/core/router/router.dart';
import 'package:exito/core/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
    context.initializeTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Grupo Exito',
      theme: AppLightTheme.instance,
      darkTheme: AppDarkTheme.instance,
      routerConfig: _appRouter.router,
    );
  }
}
