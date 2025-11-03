class Announcement {
  final String id;
  final String title;
  final String imageUrl;
  final String? description;
  final DateTime createdAt;

  Announcement({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.createdAt,
    this.description,
  });

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}
