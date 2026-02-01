import "package:go_router/go_router.dart";

import "../../auth/presentation/views/auth_view.dart";
import "routes.dart";

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: Routes.auth, builder: (context, state) => const AuthView()),
    ],
  );
}
