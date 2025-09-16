import 'package:exito/src/core/app/presentation/bloc/app_provider.dart';
import 'package:exito/src/core/extension/media_query_extension.dart';
import 'package:exito/src/core/extension/theme_extension.dart';
import 'package:exito/src/core/router/router.dart';
import 'package:exito/src/core/theme/theme.dart';
import 'package:exito/src/injection/container_injection.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

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
    return MediaQuery(
      data: context.mediaQuery.copyWith(
        textScaler: context.mediaQuery.textScaler.clamp(
          minScaleFactor: 0.8,
          maxScaleFactor: 1.3,
        ),
      ),
      child: MultiProvider(
        providers: <SingleChildWidget>[
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
