import 'dart:convert';

import 'package:booklibraryflutter/controllers/base_api_controller.dart';
import 'package:booklibraryflutter/controllers/user_controller.dart';
import 'package:booklibraryflutter/models/book.dart';
import 'package:booklibraryflutter/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final class BookController extends BaseApiController {
  final RxList<Book> books = <Book>[].obs;
  // final UserController userController = Get.find();
  late UserController userController;

  @override
  void onInit() {
    super.onInit();
    userController = Get.find();
    loadBooks();
  }

  // Get books API
  Future<void> loadBooks() async {
    final currentUser = userController.currentUser.value!;
    final url = Uri.parse('$baseUrl/${currentUser.name}/books');
    print("the url is $url");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      // Convert each item to Book
      final fetchedBooks = data.map((json) => Book.fromJson(json)).toList();
      // books.clear();
      // books.addAll(fetchedBooks);
      books.assignAll(fetchedBooks);
      // currentUser.books.clear();
      // currentUser.books.addAll(fetchedBooks);
      currentUser.books.assignAll(fetchedBooks);
      print("Fetched ${fetchedBooks.length} books for ${currentUser.name}");
    } else {
      print(
        "Failed to fetch books for ${currentUser.name}, "
        "status: ${response.statusCode}",
      );
    }
  }

  // add books API
  Future<Book?> addBook(Book book) async {
    final currentUser = userController.currentUser.value!;
    final url = Uri.parse('$baseUrl/${currentUser.name}/books');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": book.name,
        "authorId": book.author.id,
        "description": book.description,
      }),
    );
    print("Add Book response: ${response.statusCode} ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      final newBook = Book.fromJson(data);

      // Update UI list
      books.add(newBook);
      currentUser.books.add(newBook);

      return newBook;
    } else {
      print("Book not added: ${response.statusCode}");
      return null;
    }
  }
  // void addBook(Book book) {
  //   userController.currentUser.value?.books.add(book);
  // }

  // Get Favorite Books API
  Future<List<Book>> getFavBook() async {
    final currentUser = userController.currentUser.value!;
    final url = Uri.parse('$baseUrl/${currentUser.name}/books/fav');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      final fetchedBooks = data.map((json) => Book.fromJson(json)).toList();
      return fetchedBooks;
    } else {
      print("failed to fetch favorite books");
      return [];
    }
  }

  void deleteBook(Book book) {
    userController.currentUser.value?.books.remove(book);
  }

  void toggleFavorite(Book book) {
    book.isFavorite.value = !book.isFavorite.value;
  }

  List<Book> getFilteredBooks() {
    List<Book> list = books.toList();
    String filter = userController.filter.value;
    String query = userController.query.value;

    if (filter == "favorite") {
      return list.where((b) => b.isFavorite.value).toList();
    }
    if (filter == "author" && query.isNotEmpty) {
      return list
          .where(
            (b) => b.author.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    return list;
  }
}
