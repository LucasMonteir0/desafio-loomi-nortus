import "package:flutter/material.dart";
import "package:timeago/timeago.dart" as timeago;

import "app.dart";
import "modules/commons/config/dependency_injection.dart";
import "modules/commons/utils/cache/app_cache.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await AppCache.instance.init();
  timeago.setLocaleMessages("pt_BR", timeago.PtBrMessages());
  runApp(const App());
}
