import "package:shared_preferences/shared_preferences.dart";

class AppCache {
  AppCache._();

  static final AppCache instance = AppCache._();

  late final SharedPreferences _prefs;

  late bool _isLogged;
  List<int> _favoriteNewsIds = [];

  static const String _favoriteNewsKey = "favoriteNewsIds";

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isLogged = _prefs.getBool("rememberUser") ?? false;
    _loadFavoriteNewsIds();
  }

  void _loadFavoriteNewsIds() {
    final List<String>? savedIds = _prefs.getStringList(_favoriteNewsKey);
    if (savedIds != null) {
      _favoriteNewsIds = savedIds.map((e) => int.parse(e)).toList();
    }
  }

  void _saveFavoriteNewsIds() {
    final List<String> idsAsStrings = _favoriteNewsIds
        .map((e) => e.toString())
        .toList();
    _prefs.setStringList(_favoriteNewsKey, idsAsStrings);
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

  bool isFavoriteNews({required int id}) {
    return _favoriteNewsIds.contains(id);
  }

  void addFavoriteNews({required int id}) {
    if (!_favoriteNewsIds.contains(id)) {
      _favoriteNewsIds.add(id);
      _saveFavoriteNewsIds();
    }
  }

  void removeFavoriteNews({required int id}) {
    _favoriteNewsIds.remove(id);
    _saveFavoriteNewsIds();
  }

  void printFavoriteNewsIds() {
    print(_favoriteNewsIds);
  }
}
