import 'package:get/get.dart';
import 'book.dart';

class User {
  String name;
  RxList<Book> books;

  User({required this.name, required List<Book> books}) : books = books.obs;

  factory User.fromJson(Map<String, dynamic> json) {
    String name = json['name'] ?? '';

    // Safely parse books
    List<Book> books = [];
    if (json['books'] is List) {
      books = (json['books'] as List<dynamic>)
          .map((bookJson) => Book.fromJson(bookJson))
          .toList();
    }

    return User(name: name, books: books);
  }
}
