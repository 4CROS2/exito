import 'package:exito/src/features/category_detail/presentation/page/category_detail_page.dart';
import 'package:exito/src/features/home/presentation/page/home.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/home',
    routes: <RouteBase>[
      GoRoute(path: '/home', name: 'home', builder: (_, _) => const Home()),
      GoRoute(
        path: '/categoryDetail/:category',
        name: 'category Detail',
        builder: (_, GoRouterState state) {
          final String category = state.pathParameters['category']!;
          return CategoryDetailPage(categoryFilter: category);
        },
      ),
    ],
  );
}
