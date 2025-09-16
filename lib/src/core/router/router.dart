import 'package:exito/src/features/home/presentation/page/home.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/home',
    routes: <RouteBase>[
      GoRoute(path: '/home', builder: (_, _) => const Home()),
    ],
  );
}
