import 'package:booklibraryflutter/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../controllers/user_controller.dart';
import '../models/book.dart';

class BookList extends StatelessWidget {
  BookList({super.key});
  final UserController userController = Get.find();
  final BookController bookController = Get.find();

  int _crossAxisCount(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    if (breakpoints.isMobile) {
      return 1;
    }
    if (breakpoints.isTablet) {
      return 2;
    }
    if (breakpoints.isDesktop) {
      return 3;
    }
    return 4;
  }

  Widget _gridViewBooks(List<Book> books, BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: books.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _crossAxisCount(context),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        // childAspectRatio: 4 / 2, // Adjust height/width ratio
        mainAxisExtent: 130, //for fixed height of card
      ),
      itemBuilder: (context, index) {
        Book book = books[index];

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book name
                Text(
                  book.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Author
                Text(
                  book.author.name,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => IconButton(
                        icon: Icon(
                          book.isFavorite.value
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.yellow[700],
                          size: 22,
                        ),
                        onPressed: () {
                          bookController.toggleFavorite(
                            book,
                            !book.isFavorite.value,
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 22,
                      ),
                      onPressed: () => bookController.deleteBook(book),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
      return _gridViewBooks(books, context);
    });
  }
}
