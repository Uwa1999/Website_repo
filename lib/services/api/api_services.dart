import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final String _baseUrl = 'https://dev-api-janus.fortress-asya.com:18043';
  static final String _publicBase = '$_baseUrl/api/public/v1';
  static final String _privateBase = '$_baseUrl/api/private/v1';

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<String> _getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    // Try to get the username in this order:
    return prefs.getString('username') ??
        prefs.getString('email') ??
        prefs.getString('firstname') ??
        'Admin User'; // Final fallback
  }

  Future<List<Map<String, dynamic>>> fetchCatalogs() async {
    try {
      final response = await http.get(Uri.parse('$_publicBase/catalogs'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final catalogData = jsonResponse['data']['data'] as List;
        return catalogData.map<Map<String, dynamic>>((catalog) {
          return {
            'id': catalog['id'],
            'name': catalog['name'],
          };
        }).toList();
      }
      throw Exception('Failed to load catalogs: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching catalogs: $e');
    }
  }

  Future<Map<String, dynamic>> createInsight({
    required String title,
    required String content,
    required String category,
    required String eventDate,
    String? remarks,
    bool publishNow = true,
    String? scheduledAt,
    Uint8List? fileBytes,
    String? fileName,
  }) async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('Authentication token not found');
    }

    final username = await _getCurrentUsername();
    final uri = Uri.parse('$_privateBase/insights');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = 'application/json'
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['title'] = title
      ..fields['content'] = content
      ..fields['remarks'] = remarks ?? 'Main'
      ..fields['category'] = category
      ..fields['event_date'] = eventDate
      ..fields['created_by'] = username ?? 'User' // Fallback if username is null
      ..fields['publish_now'] = publishNow.toString()
      ..fields['scheduled_at'] = scheduledAt ?? '';

    if (fileBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image_path',
        fileBytes,
        filename: fileName ?? 'upload.jpg',
      ));
    }

    final response = await request.send();
    final responseBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return json.decode(responseBody.body);
    } else if (response.statusCode == 401) {
      throw Exception('Your session has expired. Please login again.');
    } else {
      throw Exception('Error: ${response.statusCode}\n${responseBody.body}');
    }
  }

  Future<Map<String, dynamic>> createCatalog({
    required String name,
    required String description,
    Uint8List? fileBytes,
    String? fileName,
  }) async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('Authentication token not found');
    }

    final username = await _getCurrentUsername();
    final uri = Uri.parse('$_privateBase/catalogs');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = 'application/json'
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['name'] = name
      ..fields['description'] = description
      ..fields['created_by'] = username ?? 'User'; // Fallback if username is null

    if (fileBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image_path',
        fileBytes,
        filename: fileName ?? 'upload.jpg',
      ));
    }

    final response = await request.send();
    final responseBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return json.decode(responseBody.body);
    } else if (response.statusCode == 401) {
      throw Exception('Your session has expired. Please login again.');
    } else {
      throw Exception('Error: ${response.statusCode}\n${responseBody.body}');
    }
  }

  Future<Map<String, dynamic>> createService({
    required int catalogId,
    required String name,
    required String description,
    Uint8List? fileBytes,
    String? fileName,
  }) async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('Authentication token not found');
    }

    final username = await _getCurrentUsername();
    final uri = Uri.parse('$_privateBase/catalogs/services/$catalogId');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = 'application/json'
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['name'] = name
      ..fields['description'] = description
      ..fields['created_by'] = username ?? 'User'; // Fallback if username is null

    if (fileBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image_path',
        fileBytes,
        filename: fileName ?? 'upload.jpg',
      ));
    }

    final response = await request.send();
    final responseBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return json.decode(responseBody.body);
    } else if (response.statusCode == 401) {
      throw Exception('Your session has expired. Please login again.');
    } else {
      throw Exception('Error: ${response.statusCode}\n${responseBody.body}');
    }
  }
}