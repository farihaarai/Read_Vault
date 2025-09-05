import 'package:booklibraryflutter/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterTabs extends StatelessWidget {
  FilterTabs({super.key});
  final UserController userController = Get.find();
  final TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: userController.filter.value == "all"
                    ? const Color.fromARGB(255, 97, 111, 189)
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
                userController.query.value = "";
                queryController.clear();
              },
              child: const Text("All"),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: userController.filter.value == "author"
                    ? const Color.fromARGB(255, 97, 111, 189)
                    : Colors.white,
                foregroundColor: userController.filter.value == "author"
                    ? Colors.white
                    : Colors.indigo,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                userController.filter.value = "author";
              },
              child: const Text("Search by Author"),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: userController.filter.value == "favorite"
                    ? const Color.fromARGB(255, 97, 111, 189)
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
                userController.query.value = "";
                queryController.clear();
              },
              child: const Text("Favorite"),
            ),
          ),
        ],
      ),
    );
  }
}
