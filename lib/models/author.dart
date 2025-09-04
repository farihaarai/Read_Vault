class Author {
  final int id;
  final String name;
  final int rating;

  Author({required this.id, required this.name, required this.rating});

  // Factory constructor
  factory Author.fromJson(Map<String, dynamic> json) {
    int id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '0') ?? 0;
    String name = json['name'] ?? '';
    int rating = json['rating'] is int
        ? json['rating']
        : int.tryParse(json['rating']?.toString() ?? '0') ?? 0;

    return Author(id: id, name: name, rating: rating);
  }

  // ✅ toJson method
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'rating': rating};
  }
}
