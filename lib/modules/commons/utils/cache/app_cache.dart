import "package:shared_preferences/shared_preferences.dart";

class AppCache {
  AppCache._();

  static final AppCache instance = AppCache._();

  late final SharedPreferences _prefs;

  late bool _isLogged;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isLogged = _prefs.getBool("rememberUser") ?? false;
  }

  void setRememberUser(bool value) {
    _prefs.setBool("rememberUser", value);
  }

  bool getRememberUser() {
    return _prefs.getBool("rememberUser") ?? false;
  }

  bool get isLogged {
    return _isLogged;
  }

  void setIsLogged(bool value) {
    _isLogged = value;
  }
}
