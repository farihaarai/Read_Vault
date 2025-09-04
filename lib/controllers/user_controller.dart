import 'package:get/get.dart';
import '../models/book.dart';
import '../models/user.dart';

class UserController extends GetxController {
  // 1) Explicit reactive type (no `var`)
  final RxList<User> users = <User>[].obs;

  // Optional: Rxn is the idiomatic nullable Rx
  final Rxn<User> currentUser = Rxn<User>();

  final RxString filter = "all".obs;
  final RxString query = "".obs;

  @override
  void onInit() {
    super.onInit();

    // 2) Explicitly typed list literals to avoid List<dynamic>
    users.addAll(<User>[
      User(
        name: "AKSHADA",
        books: <Book>[
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
          Book(
            id: 7,
            name: "The Alchemist",
            author: "Paulo Coelho",
            description: "A philosophical novel",
            isFavorite: true,
          ),
          Book(
            id: 8,
            name: "Becoming",
            author: "Michelle Obama",
            description: "Memoir of First Lady",
          ),
          Book(
            id: 9,
            name: "Educated",
            author: "Tara Westover",
            description: "A memoir about education",
          ),
        ],
      ),
      User(
        name: "PATRICK",
        books: <Book>[
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

    // Safe pick
    currentUser.value = users.isNotEmpty ? users.first : null;
  }

  void selectUser(User u) {
    currentUser.value = u;
    // filter.value = "all";
    // query.value = "";
  }

  void addBook(Book book) {
    currentUser.value?.books.add(book);
  }

  void deleteBook(Book book) {
    currentUser.value?.books.remove(book);
  }

  void toggleFavorite(Book book) {
    book.isFavorite.value = !book.isFavorite.value;
  }

  List<Book> getFilteredBooks() {
    List<Book> books = currentUser.value?.books ?? [];

    if (filter.value == "favorite") {
      return books.where((b) => b.isFavorite.value).toList();
    }

    if (filter.value == "author" && query.value.isNotEmpty) {
      return books
          .where(
            (b) => b.author.toLowerCase().contains(query.value.toLowerCase()),
          )
          .toList();
    }

    return books;
  }
}
