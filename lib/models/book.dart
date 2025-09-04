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
}
