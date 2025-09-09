import 'package:booklibraryflutter/controllers/author_controller.dart';
import 'package:booklibraryflutter/controllers/book_controller.dart';
import 'package:booklibraryflutter/widgets/book_list.dart';
import 'package:booklibraryflutter/widgets/filter_tabs.dart';
import 'package:booklibraryflutter/widgets/user_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../controllers/user_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UserController userController = Get.find();
  final AuthorController authorController = Get.find();
  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ResponsiveBreakpointsData breakpoints = ResponsiveBreakpoints.of(
      context,
    );
    final bool isMobile = breakpoints.isMobile;
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade400, Colors.indigo.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Greeting + Top-right Add Button (tablet/desktop)
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          final userName =
                              userController.currentUser.value?.name ?? '';
                          return Text(
                            "Welcome, $userName! 👋",
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),
                      if (!isMobile) _addBookButton(),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // User Tabs
                  UserTabs(),
                  const SizedBox(height: 20),

                  // Add Book Button (only for mobile)
                  if (isMobile)
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: _addBookButton(),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),

                  // Filter Buttons
                  FilterTabs(),
                  const SizedBox(height: 15),

                  // Author Search
                  Obx(() {
                    if (userController.filter.value == "author") {
                      return Card(
                        color: Colors.white.withOpacity(0.9),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: queryController,
                                  decoration: const InputDecoration(
                                    hintText: "Search by author",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo[700],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                ),
                                onPressed: () async {
                                  userController.query.value =
                                      queryController.text;
                                  final books = await authorController
                                      .getBooksByAuthor(queryController.text);
                                  final bookController =
                                      Get.find<BookController>();
                                  bookController.books.assignAll(books);
                                },
                                child: const Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                  const SizedBox(height: 15),

                  // Book List in flexible container with gradient background
                  Expanded(child: BookList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addBookButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.indigo,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => Get.toNamed("/add-book"),
      icon: const Icon(Icons.add),
      label: const Text(
        "Add Book",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
