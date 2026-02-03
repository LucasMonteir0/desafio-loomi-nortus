import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../news/core/domain/entities/news_item_entity.dart";

class AppCache {
  AppCache._();

  static final AppCache instance = AppCache._();

  late final SharedPreferences _prefs;

  late bool _isLogged;
  final Set<NewsItemEntity> _favoriteNews = {};
  final ValueNotifier<List<NewsItemEntity>> _favoriteNewsNotifier =
      ValueNotifier([]);

  ValueNotifier<List<NewsItemEntity>> get favoriteNewsNotifier =>
      _favoriteNewsNotifier;

  void _updateFavoriteNews() {
    _favoriteNewsNotifier.value = List.unmodifiable(_favoriteNews);
  }

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

  bool isFavoriteNews(NewsItemEntity news) {
    return _favoriteNews.contains(news);
  }

  bool isFavoriteNewsById(int id) {
    return _favoriteNews.any((element) => element.id == id);
  }

  void addFavoriteNews({required NewsItemEntity news}) {
    if (!_favoriteNews.any((e) => e.id == news.id)) {
      _favoriteNews.add(news);
    }
    _updateFavoriteNews();
  }

  void removeFavoriteNews({required NewsItemEntity news}) {
    _favoriteNews.removeWhere((e) => e.id == news.id);
    _updateFavoriteNews();
  }

  List<NewsItemEntity> getFavoriteNews() {
    return List.unmodifiable(_favoriteNews);
  }
}
