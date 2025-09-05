class Author {
  final int id;
  final String name;
  final int rating;

  Author({required this.id, required this.name, required this.rating});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }
}
