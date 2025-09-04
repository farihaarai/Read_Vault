import 'package:get/get.dart';

import 'book.dart';

class User {
  String name;
  RxList<Book> books;

  User({required this.name, required List<Book> books}) : books = books.obs;
}
