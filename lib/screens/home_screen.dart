import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/book.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("📖 Read Vault 📖")),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // User Tabs
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: userController.users.map((u) {
                bool isActive =
                    userController.currentUser.value?.name == u.name;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isActive
                            ? Colors.indigo
                            : Colors.white,
                        foregroundColor: isActive
                            ? Colors.white
                            : Colors.indigo,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () => userController.selectUser(u),
                      child: Text(u.name),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          // Add Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Get.toNamed("/add-book"),
            child: const Text("ADD"),
          ),
          SizedBox(height: 25),
          // Filter Buttons
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: userController.filter.value == "all"
                          ? Colors.indigo
                          : Colors.white,
                      foregroundColor: userController.filter.value == "all"
                          ? Colors.white
                          : Colors.indigo,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      userController.filter.value = "all";
                    },
                    child: const Text("All"),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: userController.filter.value == "author"
                          ? Colors.indigo
                          : Colors.white,
                      foregroundColor: userController.filter.value == "author"
                          ? Colors.white
                          : Colors.indigo,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed("/search-by-author");
                    },
                    child: const Text("Author"),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: userController.filter.value == "favorite"
                          ? Colors.indigo
                          : Colors.white,
                      foregroundColor: userController.filter.value == "favorite"
                          ? Colors.white
                          : Colors.indigo,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      userController.filter.value = "favorite";
                    },
                    child: const Text("Favorite"),
                  ),
                ),
              ],
            ),
          ),

          // Book List
          Expanded(
            child: Obx(() {
              var books = userController.filteredBooks;
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
                              book.isFavorite.value
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.yellow,
                            ),
                            onPressed: () =>
                                userController.toggleFavorite(book),
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
            }),
          ),
        ],
      ),
    );
  }
}
