// lib/providers/article_provider.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleProvider extends ChangeNotifier {
  Map<String, dynamic>? _articleData;
  String? _currentArticleId;

  Map<String, dynamic>? get articleData => _articleData;
  String? get currentArticleId => _currentArticleId;

  Future<void> setArticleData(Map<String, dynamic> data) async {
    _articleData = data;
    _currentArticleId = data['id']?.toString();
    await _saveToPrefs(data);
    notifyListeners();
  }

  Future<void> loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('article_data');
      if (jsonString != null) {
        final data = json.decode(jsonString);
        if (_isValidArticleData(data)) {
          _articleData = data;
          _currentArticleId = data['id']?.toString();
          notifyListeners();
        } else {
          await prefs.remove('article_data');
        }
      }
    } catch (e) {
      print('Error loading article from prefs: $e');
    }
  }

  Future<void> _saveToPrefs(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('article_data', json.encode(data));
    } catch (e) {
      print('Error saving article to prefs: $e');
    }
  }

  bool _isValidArticleData(Map<String, dynamic>? data) {
    return data != null &&
        data['id'] != null &&
        data['title'] != null &&
        data['content'] != null;
  }

  Future<void> clear() async {
    _articleData = null;
    _currentArticleId = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('article_data');
    notifyListeners();
  }
}