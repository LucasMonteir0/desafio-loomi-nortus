import "package:shared_preferences/shared_preferences.dart";

class AppCache {
  AppCache._();

  static final AppCache instance = AppCache._();

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
