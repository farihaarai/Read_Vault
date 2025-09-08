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
  final authorNameController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a Book")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: "ID",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 15),

            // TextField(
            //   controller: authorNameController,
            //   decoration: const InputDecoration(labelText: "Author"),
            // ),
            Obx(
              () => DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                isExpanded: true,
                hint: const Text("Select Author"),
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
            SizedBox(height: 15),

            TextField(
              controller: descController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (idController.text.isEmpty ||
                    nameController.text.isEmpty ||
                    authorController.selectedAuthorId.value == 0 ||
                    descController.text.isEmpty) {
                  Get.snackbar("Error", "Fill all fields");
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
              child: const Text("ADD"),
            ),
          ],
        ),
      ),
    );
  }
}
