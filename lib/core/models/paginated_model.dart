import 'article_model.dart';

class PaginatedResponse {
  final List<Article> items;
  final int totalCount;  // Matches 'totalCount' from API
  final int currentPage; // Matches 'currentPage' from API
  final int totalPages;  // Matches 'totalPages' from API

  PaginatedResponse({
    required this.items,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedResponse(
      items: (json['data'] as List).map((i) => Article.fromJson(i)).toList(),
      totalCount: json['totalCount'] ?? 0,
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
    );
  }
}