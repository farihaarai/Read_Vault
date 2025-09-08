import 'package:booklibraryflutter/controllers/author_controller.dart';
import 'package:booklibraryflutter/controllers/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/book.dart';

class AddBookScreen extends StatelessWidget {
  AddBookScreen({super.key});
  final UserController userController = Get.find();
  final BookController bookController = Get.find();
  final AuthorController authorController = Get.find();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Every Book Counts! Add One Now"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ID field
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Book ID",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.confirmation_number),
              ),
            ),
            const SizedBox(height: 15),

            // Name field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Book Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.book),
              ),
            ),
            const SizedBox(height: 15),

            // Author dropdown
            Obx(
              () => DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: "Select Author",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                isExpanded: true,
                value: authorController.selectedAuthorId.value == 0
                    ? null
                    : authorController.selectedAuthorId.value,
                items: authorController.authors
                    .map(
                      (author) => DropdownMenuItem<int>(
                        value: author.id,
                        child: Text(author.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    authorController.selectedAuthorId.value = value;
                  }
                },
              ),
            ),
            const SizedBox(height: 15),

            // Description field
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 25),

            // Add button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (idController.text.isEmpty ||
                      nameController.text.isEmpty ||
                      authorController.selectedAuthorId.value == 0 ||
                      descController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please fill all fields",
                      backgroundColor: Colors.red[300],
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  final selectedAuthor = authorController.authors.firstWhere(
                    (a) => a.id == authorController.selectedAuthorId.value,
                  );

                  final book = Book(
                    id: int.parse(idController.text),
                    name: nameController.text,
                    author: selectedAuthor,
                    description: descController.text,
                  );

                  bookController.addBook(book);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add Book",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
