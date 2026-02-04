import "dart:convert";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../news/core/domain/entities/news_item_entity.dart";
import "../../../profile/core/data/models/profile_model.dart";
import "../../../profile/core/domain/entities/profile_entity.dart";

class _CacheKey {
  static const String rememberUser = "rememberUser";
  static const String userProfile = "userProfile";
}

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
    _isLogged = _prefs.getBool(_CacheKey.rememberUser) ?? false;
  }

  void setRememberUser(bool value) {
    _prefs.setBool(_CacheKey.rememberUser, value);
  }

  bool getRememberUser() {
    return _prefs.getBool(_CacheKey.rememberUser) ?? false;
  }

  bool get isLogged {
    return _isLogged;
  }

  void setIsLogged(bool value) {
    _isLogged = value;
  }

  void setProfile(ProfileEntity? profile) {
    if (profile != null) {
      final model = ProfileModel.fromEntity(profile);
      _prefs.setString(_CacheKey.userProfile, jsonEncode(model.toJson()));
    } else {
      _prefs.remove(_CacheKey.userProfile);
    }
  }

  ProfileEntity? getProfile() {
    final profileJson = _prefs.getString(_CacheKey.userProfile);
    if (profileJson != null) {
      return ProfileModel.fromJson(jsonDecode(profileJson));
    }
    return null;
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
