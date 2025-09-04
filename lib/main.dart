import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/add_book_screen.dart';
// import 'screens/author_search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reading List',
      initialRoute: '/Dashboard',
      getPages: [
        GetPage(name: '/Dashboard', page: () => HomeScreen()),
        GetPage(name: '/add-book', page: () => AddBookScreen()),
        // GetPage(name: '/search-by-author', page: () => AuthorSearchScreen()),
      ],
    );
  }
}
