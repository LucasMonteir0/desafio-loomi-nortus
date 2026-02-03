import "package:shared_preferences/shared_preferences.dart";

class AppCache {
  AppCache._();

  static final AppCache instance = AppCache._();

  late final SharedPreferences _prefs;

  late bool _isLogged;
  final List<int> _favoriteNewsIds = [];

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

  bool isFavoriteNews(int id) {
    return _favoriteNewsIds.contains(id);
  }

  void addFavoriteNews({required int id}) {
    if (!_favoriteNewsIds.contains(id)) {
      _favoriteNewsIds.add(id);
    }
  }

  void removeFavoriteNews({required int id}) {
    _favoriteNewsIds.remove(id);
  }

  List<int> getFavoriteNewsIds() {
    return List.unmodifiable(_favoriteNewsIds);
  }
}
