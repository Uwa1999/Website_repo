import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/article_model.dart';
import '../../core/models/paginated_model.dart';
import '../../core/models/products_and_services_model.dart';

class ArticleApiService {
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<PaginatedResponse<Article>> fetchPaginatedArticles({int page = 1}) async {
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
        return PaginatedResponse<Article>.fromJson(
          jsonData['data'],
              (item) => Article.fromJson(item),
        );
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }

  Future<PaginatedResponse<Catalog>> fetchPaginatedCatalogs({int page = 1}) async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse(
          'https://dev-api-janus.fortress-asya.com:18043/api/private/v1/catalogs/index?page=$page',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Ensure the API returns the same structure
        return PaginatedResponse<Catalog>.fromJson(
          jsonData['data'],
              (item) => Catalog.fromJson(item),
        );
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to load catalogs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch catalogs: $e');
    }
  }


  Future<PaginatedResponse<Service>> fetchPaginatedServices({int page = 1}) async {
    try {
      final token = await _getAuthToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      // Note: You might need to adjust this endpoint based on your API
      // If services don't have their own endpoint, you might need to extract them from catalogs
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/services?page=$page'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PaginatedResponse<Service>.fromJson(
          jsonData['data'],
              (item) => Service.fromJson(item),
        );
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        // If services endpoint doesn't exist, we'll extract services from catalogs
        return await _extractServicesFromCatalogs(page: page);
      }
    } catch (e) {
      // If services endpoint doesn't exist, we'll extract services from catalogs
      return await _extractServicesFromCatalogs(page: page);
    }
  }

  Future<PaginatedResponse<Service>> _extractServicesFromCatalogs({int page = 1}) async {
    try {
      final catalogsResponse = await fetchPaginatedCatalogs(page: page);

      // Extract all services from all catalogs
      List<Service> allServices = [];
      for (var catalog in catalogsResponse.items) {
        if (catalog.services != null) {
          allServices.addAll(catalog.services!);
        }
      }

      // For simplicity, we're returning all services without pagination
      // In a real implementation, you'd need to implement proper pagination
      return PaginatedResponse<Service>(
        items: allServices,
        totalCount: allServices.length,
        totalPages: 1,
        currentPage: 1,
      );
    } catch (e) {
      throw Exception('Failed to extract services from catalogs: $e');
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

  // Add similar delete methods for catalogs and services if needed
  // In your ArticleApiService class, add this method
  Future<bool> deleteCatalogs(List<int> ids) async {
    try {
      final token = await _getAuthToken();
      if (token == null) throw Exception('Authentication token not found');

      final response = await http.delete(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/private/v1/catalogs'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'ids': ids}),
      );

      if (response.statusCode == 200 || response.statusCode == 205) {
        final responseBody = json.decode(response.body);
        return responseBody['data']['success'] == true;
      } else {
        throw Exception('Failed to delete catalogs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete catalogs: $e');
    }
  }

  // In your ArticleApiService class, add this method
  Future<bool> deleteServices(List<int> ids) async {
    try {
      final token = await _getAuthToken();
      if (token == null) throw Exception('Authentication token not found');

      final response = await http.delete(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/private/v1/catalogs/services'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'ids': ids}),
      );

      if (response.statusCode == 200 || response.statusCode == 205) {
        final responseBody = json.decode(response.body);
        return responseBody['data']['success'] == true;
      } else {
        throw Exception('Failed to delete services: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete services: $e');
    }
  }
}