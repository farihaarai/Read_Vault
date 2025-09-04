import 'package:get/get.dart';
import '../models/book.dart';
import '../models/user.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var currentUser = Rx<User?>(null);
  var filter = "all".obs;
  var query = "".obs;

  @override
  void onInit() {
    super.onInit();
    // Predefined users
    users.addAll([
      User(
        name: "AKSHADA",
        books: [
          Book(
            id: 1,
            name: "The Alchemist",
            author: "Paulo Coelho",
            description: "A philosophical novel",
            isFavorite: true,
          ),
          Book(
            id: 2,
            name: "Becoming",
            author: "Michelle Obama",
            description: "Memoir of First Lady",
          ),
          Book(
            id: 3,
            name: "Educated",
            author: "Tara Westover",
            description: "A memoir about education",
          ),
        ],
      ),
      User(
        name: "PATRICK",
        books: [
          Book(
            id: 4,
            name: "Sapiens",
            author: "Yuval Noah Harari",
            description: "History of humankind",
          ),
          Book(
            id: 5,
            name: "Atomic Habits",
            author: "James Clear",
            description: "Habits building",
            isFavorite: true,
          ),
          Book(
            id: 6,
            name: "The Midnight Library",
            author: "Matt Haig",
            description: "Novel about choices",
          ),
        ],
      ),
    ]);

    currentUser.value = users[0];
  }

  void selectUser(User u) {
    currentUser.value = u;
    filter.value = "all";
    query.value = "";
  }

  void addBook(Book book) {
    currentUser.value?.books.add(book);
  }

  void deleteBook(Book book) {
    currentUser.value?.books.remove(book);
  }

  void toggleFavorite(Book book) {
    book.isFavorite = !book.isFavorite;
  }

  List<Book> get filteredBooks {
    var books = currentUser.value?.books ?? [];
    if (filter.value == "favorite") {
      books = books.where((b) => b.isFavorite).toList();
    }
    if (filter.value == "author" && query.value.isNotEmpty) {
      books = books
          .where((b) => b.author.toLowerCase() == query.value.toLowerCase())
          .toList();
    }
    return books;
  }
}
