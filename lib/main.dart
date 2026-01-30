import "package:flutter/material.dart";

import "modules/commons/utils/cache/app_cache.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppCache.instance.init();
  runApp(const MyApp());
}
