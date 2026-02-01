import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";

import "../../config/routes.dart";
import "../cache/app_cache.dart";

class AuthGuard {
  AuthGuard._();

  static String? redirect(BuildContext context, GoRouterState state) {
    final isLogged = AppCache.instance.isLogged;

    if (!isLogged) {
      return Routes.auth;
    }

    return null;
  }
}
