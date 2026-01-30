import "package:flutter/material.dart";

import "app.dart";
import "modules/commons/config/dependency_injection.dart";
import "modules/commons/utils/cache/app_cache.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await AppCache.instance.init();
  runApp(App());
}
