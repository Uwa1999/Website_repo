import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/article_model.dart';
import '../../core/models/paginated_model.dart';

class ArticleApiService {
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<PaginatedResponse> fetchPaginatedArticles({int page = 1}) async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/private/v1/insights/index?page=$page'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PaginatedResponse.fromJson(jsonData['data']);
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }

  Future<bool> deleteInsights(List<int> ids) async {
    final token = await _getAuthToken();
    if (token == null) throw Exception('Authentication token not found');

    final response = await http.delete(
      Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/private/v1/insights/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'ids': ids}),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete insights: ${response.body}');
    }
  }
}