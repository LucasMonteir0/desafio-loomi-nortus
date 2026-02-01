import "package:flutter/material.dart";

import "modules/commons/config/app_router.dart";
import "modules/commons/config/routes.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter.router.go(Routes.auth);
    return MaterialApp.router(
      title: "Nortus",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
