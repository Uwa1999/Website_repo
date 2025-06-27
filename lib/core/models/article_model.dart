class Article {
  final String category;
  final int clickCount;
  final String content;
  final String createdAt;
  final String createdBy;
  final String eventDate;
  final int id;
  final String imagePath;
  final bool isEnabled;
  final bool isPublished;
  final String publishedAt;
  final String remarks;
  final String? scheduledAt;
  final String title;

  Article({
    required this.category,
    required this.clickCount,
    required this.content,
    required this.createdAt,
    required this.createdBy,
    required this.eventDate,
    required this.id,
    required this.imagePath,
    required this.isEnabled,
    required this.isPublished,
    required this.publishedAt,
    required this.remarks,
    this.scheduledAt,
    required this.title,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      category: json['category'] ?? '',
      clickCount: json['click_count'] ?? 0,
      content: json['content'] ?? '',
      createdAt: json['created_at'] ?? '',
      createdBy: json['created_by'] ?? '',
      eventDate: json['event_date'] ?? '',
      id: json['id'] ?? 0,
      imagePath: json['image_path'] ?? '',
      isEnabled: json['is_enabled'] ?? false,
      isPublished: json['is_published'] ?? false,
      publishedAt: json['published_at'] ?? '',
      remarks: json['remarks'] ?? '',
      scheduledAt: json['scheduled_at'],
      title: json['title'] ?? '',
    );
  }
}