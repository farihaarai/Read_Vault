import 'package:booklibraryflutter/widgets/book_list.dart';
import 'package:booklibraryflutter/widgets/filter_tabs.dart';
import 'package:booklibraryflutter/widgets/user_tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UserController userController = Get.put(UserController());
  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("📖 Read Vault 📖")),
        backgroundColor: Colors.white,
        foregroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          // User Tabs
          UserTabs(),
          const SizedBox(height: 20),

          // Add Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 97, 111, 189),
              foregroundColor: Colors.white,
            ),
            onPressed: () => Get.toNamed("/add-book"),
            child: const Text("ADD"),
          ),
          const SizedBox(height: 25),

          // Filter Buttons
          FilterTabs(),
          // Inline Author Search Bar
          Obx(() {
            if (userController.filter.value == "author") {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: queryController,
                        decoration: const InputDecoration(
                          labelText: "Enter author name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          103,
                          113,
                          172,
                        ),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        userController.query.value = queryController.text;
                      },
                      child: const Icon(Icons.search),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          }),
          // Book List
          Expanded(child: BookList()),
        ],
      ),
    );
  }
}
