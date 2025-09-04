import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/book.dart';

class AddBookScreen extends StatelessWidget {
  AddBookScreen({super.key});
  final UserController userController = Get.find();

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final authorController = TextEditingController();
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
              decoration: const InputDecoration(labelText: "ID"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: "Author"),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (idController.text.isEmpty ||
                    nameController.text.isEmpty ||
                    authorController.text.isEmpty ||
                    descController.text.isEmpty) {
                  Get.snackbar("Error", "Fill all fields");
                  return;
                }
                final book = Book(
                  id: int.parse(idController.text),
                  name: nameController.text,
                  author: authorController.text,
                  description: descController.text,
                );
                userController.addBook(book);
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
