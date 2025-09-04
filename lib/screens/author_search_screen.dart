// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/user_controller.dart';

// class AuthorSearchScreen extends StatelessWidget {
//   AuthorSearchScreen({super.key});
//   final UserController userController = Get.find();
//   final queryController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Search Author")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: queryController,
//               decoration: const InputDecoration(labelText: "Author name"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 userController.query.value = queryController.text;
//                 userController.filter.value = "author";
//                 Get.back();
//               },
//               child: const Text("SEARCH"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
