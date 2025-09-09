class ClientSection {
  final int id;
  final String sectionName;
  final List<String> logos;

  ClientSection({
    required this.id,
    required this.sectionName,
    required this.logos,
  });

  factory ClientSection.fromJson(Map<String, dynamic> json) {
    return ClientSection(
      id: json['id'],
      sectionName: json['section_name'],
      logos: List<String>.from(json['logos']),
    );
  }
}