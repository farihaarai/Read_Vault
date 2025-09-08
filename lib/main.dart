import 'package:booklibraryflutter/controllers/author_controller.dart';
import 'package:booklibraryflutter/controllers/book_controller.dart';
import 'package:booklibraryflutter/controllers/user_controller.dart';
import 'package:booklibraryflutter/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/add_book_screen.dart';
// import 'screens/author_search_screen.dart';

void main() {
  Get.put(UserController());
  Get.put(BookController());
  Get.put(AuthorController());
  // Get.lazyPut(()=>UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Read Vault App',
      initialRoute: '/Welcome',
      getPages: [
        GetPage(name: '/Welcome', page: () => InitialScreen()),
        GetPage(name: '/Dashboard', page: () => HomeScreen()),
        GetPage(name: '/add-book', page: () => AddBookScreen()),
      ],
    );
  }
}
