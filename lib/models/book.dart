import 'package:get/get.dart';

class Book {
  int id;
  String name;
  String author;
  String description;
  RxBool isFavorite;

  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    bool isFavorite = false,
  }) : isFavorite = isFavorite.obs;

  // ✅ Factory constructor
  factory Book.fromJson(Map<String, dynamic> json) {
    int id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '0') ?? 0;
    String name = json['name'] ?? '';
    String author = json['author'] ?? '';
    String description = json['description'] ?? '';
    bool isFavorite = json['isFavorite'] == true;

    return Book(
      id: id,
      name: name,
      author: author,
      description: description,
      isFavorite: isFavorite,
    );
  }

  // ✅ toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'description': description,
      'isFavorite': isFavorite.value,
    };
  }
}
