class Book {
  final int id;
  final String title;
  final String createdAt;
  final String updatedAt;

  Book({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
