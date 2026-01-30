import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "modules/auth/presentation/views/auth_view.dart";
import "modules/commons/config/routes.dart";

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Nortus",
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(path: Routes.auth, builder: (context, state) => const AuthView()),
    ],
  );
}
