import 'package:exito/src/core/app/presentation/bloc/app_provider.dart';
import 'package:exito/src/core/router/router.dart';
import 'package:exito/src/core/theme/theme.dart';
import 'package:exito/src/injection/container_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/shared.dart';

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
    AppLightTheme.initialize(context);
    AppDarkTheme.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: context.mediaQuery.copyWith(
        textScaler: context.mediaQuery.textScaler.clamp(
          minScaleFactor: 0.8,
          maxScaleFactor: 1.3,
        ),
      ),
      child: MultiProvider(
        providers: <ListenableProvider<dynamic>>[
          ChangeNotifierProvider<AppProvider>(
            create: (BuildContext context) => sl<AppProvider>(),
          ),
        ],
        child: Builder(
          builder: (BuildContext context) {
            final AppProvider appProvider = context.watch<AppProvider>();
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Grupo Exito',
              theme: AppLightTheme.instance,
              darkTheme: AppDarkTheme.instance,
              themeMode: appProvider.themeMode,
              routerConfig: _appRouter.router,
            );
          },
        ),
      ),
    );
  }
}
