import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/book.dart';

class BookList extends StatelessWidget {
  BookList({super.key});
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var books = userController.getFilteredBooks();

      if (books.isEmpty) {
        return const Center(child: Text("No books found."));
      }

      return ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          Book book = books[index];
          return ListTile(
            title: Text(book.name),
            subtitle: Text(book.author),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => IconButton(
                    icon: Icon(
                      book.isFavorite.value ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    ),
                    onPressed: () => userController.toggleFavorite(book),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => userController.deleteBook(book),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
