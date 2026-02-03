import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../auth/presentation/views/auth_view.dart";
import "../../home/presentation/views/home_view.dart";
import "../../news/presentation/views/news/news_view.dart";
import "../../news/presentation/views/news_details/news_details_view.dart";
import "../../profile/presentation/views/profile_view.dart";
import "../utils/guards/auth_guard.dart";
import "routes.dart";

class AppRouter {
  AppRouter._();
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.news,
    redirect: AuthGuard.redirect,
    routes: [
      GoRoute(path: Routes.auth, builder: (context, state) => const AuthView()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.news,
                builder: (_, _) => const NewsView(),
                routes: [
                  GoRoute(
                    path: ":id",
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final newsId = int.parse(
                        state.pathParameters["id"] ?? "0",
                      );
                      return NewsDetailsView(newsId: newsId);
                    },
                  ),
                ],
              ),
            ],
          ),
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
