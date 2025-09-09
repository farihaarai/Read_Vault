import 'dart:developer';

import 'package:booklibraryflutter/controllers/book_controller.dart';
import 'package:booklibraryflutter/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FilterTabs extends StatelessWidget {
  FilterTabs({super.key});
  final UserController userController = Get.find();
  final BookController bookController = Get.find();
  final TextEditingController queryController = TextEditingController();

  // value is the filter selected & label is button label
  Widget buildTab(String label, String value, {bool withIcon = false}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: userController.filter.value == value
            ? const Color.fromARGB(255, 97, 111, 189)
            : Colors.white,
        foregroundColor: userController.filter.value == value
            ? Colors.white
            : Colors.indigo,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: () {
        userController.filter.value = value;
        userController.query.value = "";
        queryController.clear();

        if (value == "favorite") {
          bookController.getFavBook();
        }
      },
      // icon: Icon(Icons.search),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (withIcon)
            const Padding(
              padding: EdgeInsets.only(right: 6),
              child: Icon(Icons.search, size: 18, color: Colors.indigo),
            ),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    log("Is Rebuild");
    return Obx(
      () => Row(
        mainAxisAlignment: isMobile
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          isMobile
              ? Expanded(child: buildTab('All', "all"))
              : buildTab('All', "all"),
          SizedBox(width: 10),
          isMobile
              ? Expanded(child: buildTab("Author", "author", withIcon: true))
              : buildTab("Author", "author", withIcon: true),
          SizedBox(width: 10),
          isMobile
              ? Expanded(child: buildTab("Favorite", "favorite"))
              : buildTab("Favorite", "favorite"),
        ],
        // children: [
        //   Expanded(
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: userController.filter.value == "all"
        //             ? const Color.fromARGB(255, 97, 111, 189)
        //             : Colors.white,
        //         foregroundColor: userController.filter.value == "all"
        //             ? Colors.white
        //             : Colors.indigo,
        //         shape: const RoundedRectangleBorder(
        //           borderRadius: BorderRadius.zero,
        //         ),
        //       ),
        //       onPressed: () {
        //         userController.filter.value = "all";
        //         userController.query.value = "";
        //         queryController.clear();
        //       },
        //       child: const Text("All"),
        //     ),
        //   ),
        //   const SizedBox(width: 5),
        //   Expanded(
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: userController.filter.value == "author"
        //             ? const Color.fromARGB(255, 97, 111, 189)
        //             : Colors.white,
        //         foregroundColor: userController.filter.value == "author"
        //             ? Colors.white
        //             : Colors.indigo,
        //         shape: const RoundedRectangleBorder(
        //           borderRadius: BorderRadius.zero,
        //         ),
        //       ),
        //       onPressed: () {
        //         userController.filter.value = "author";
        //       },
        //       child: const Text("Search by Author"),
        //     ),
        //   ),
        //   const SizedBox(width: 5),
        //   Expanded(
        //     child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: userController.filter.value == "favorite"
        //             ? const Color.fromARGB(255, 97, 111, 189)
        //             : Colors.white,
        //         foregroundColor: userController.filter.value == "favorite"
        //             ? Colors.white
        //             : Colors.indigo,
        //         shape: const RoundedRectangleBorder(
        //           borderRadius: BorderRadius.zero,
        //         ),
        //       ),
        //       onPressed: () {
        //         userController.filter.value = "favorite";
        //         bookController.getFavBook();
        //         userController.query.value = "";
        //         queryController.clear();
        //       },
        //       child: const Text("Favorite"),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
