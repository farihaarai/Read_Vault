import 'package:booklibraryflutter/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/book.dart';

class BookList extends StatelessWidget {
  BookList({super.key});
  final UserController userController = Get.find();
  final BookController bookController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get filtered books according to the selected filter or author search
      var books = bookController.getFilteredBooks();

      if (books.isEmpty) {
        return const Center(
          child: Text(
            "No books found.",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        );
      }

      return ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          Book book = books[index];

          // Each book is displayed as a Card to match HomeScreen styling
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),

              // Book name and author
              title: Text(
                book.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              subtitle: Text(
                book.author.name,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),

              // Favorite star and delete button
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        book.isFavorite.value ? Icons.star : Icons.star_border,
                        color: Colors.yellow[700],
                        size: 24,
                      ),
                      onPressed: () {
                        // Toggle favorite status
                        bookController.toggleFavorite(
                          book,
                          !book.isFavorite.value,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 24),
                    onPressed: () => bookController.deleteBook(book),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
