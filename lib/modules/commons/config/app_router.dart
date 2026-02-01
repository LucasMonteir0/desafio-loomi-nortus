import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../auth/presentation/views/auth_view.dart";
import "../../home/presentation/views/home_view.dart";
import "../../news/presentation/views/news_view.dart";
import "../../profile/presentation/views/profile_view.dart";
import "../utils/guards/auth_guard.dart";
import "routes.dart";

class AppRouter {
  AppRouter._();
  static final router = GoRouter(
    initialLocation: Routes.news,
    redirect: AuthGuard.redirect,
    routes: [
      GoRoute(path: Routes.auth, builder: (context, state) => const AuthView()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeView(navigationShell: navigationShell);
        },
        branches: [
          _RouterHelper.branch(Routes.news, const NewsView()),
          _RouterHelper.branch(Routes.profile, const ProfileView()),
        ],
      ),
    ],
  );
}

class _RouterHelper {
  _RouterHelper._();
  static StatefulShellBranch branch(String path, Widget page) {
    return StatefulShellBranch(
      routes: [GoRoute(path: path, builder: (_, _) => page)],
    );
  }
}
