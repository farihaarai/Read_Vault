import 'package:booklibraryflutter/models/author.dart';
import 'package:get/get.dart';

class Book {
  int id;
  String name;
  Author author;
  String description;
  RxBool isFavorite;

  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    bool isFavorite = false,
  }) : isFavorite = isFavorite.obs;

  // Factory constructor
  factory Book.fromJson(Map<String, dynamic> json) {
    int id = json['id'] is int
        ? json['id']
        : int.tryParse(json['id']?.toString() ?? '0') ?? 0;

    String name = json['name'] ?? '';
    Author author = Author.fromJson(json['author']);
    String description = json['description'] ?? '';
    bool isFavorite = json['favourite'] == true || json['isFavorite'] == true;

    return Book(
      id: id,
      name: name,
      author: author,
      description: description,
      isFavorite: isFavorite,
    );
  }
}
