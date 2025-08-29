// catalog_model.dart
// catalog_model.dart
class Catalog {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final bool isEnabled;
  final String createdAt;
  final String createdBy;
  final String? updatedAt;
  final String? updatedBy;
  final List<Service>? services;
  final int servicesCount;

  Catalog({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.isEnabled,
    required this.createdAt,
    required this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.services,
    required this.servicesCount,
  });

  factory Catalog.fromJson(Map<String, dynamic> json) {
    return Catalog(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imagePath: json['image_path'],
      isEnabled: json['is_enabled'],
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      services: json['services'] != null
          ? List<Service>.from(json['services'].map((x) => Service.fromJson(x)))
          : null,
      servicesCount: json['services_count'],
    );
  }
}

// service_model.dart
// service_model.dart
class Service {
  final int id;
  final String name;
  final String description;
  final String imagePath;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imagePath: json['image_path'],
    );
  }
}