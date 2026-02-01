import "package:go_router/go_router.dart";

import "../../auth/presentation/views/auth_view.dart";
import "../../home/presentation/views/home_view.dart";
import "../utils/guards/auth_guard.dart";
import "routes.dart";

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: Routes.auth, builder: (context, state) => const AuthView()),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeView(),
        redirect: AuthGuard.redirect,
      ),
    ],
  );
}
