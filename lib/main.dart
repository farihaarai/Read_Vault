import 'package:booklibraryflutter/controllers/author_controller.dart';
import 'package:booklibraryflutter/controllers/book_controller.dart';
import 'package:booklibraryflutter/controllers/user_controller.dart';
import 'package:booklibraryflutter/screens/initial_screen.dart';
import 'package:booklibraryflutter/screens/home_screen.dart';
import 'package:booklibraryflutter/screens/add_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  Get.put(UserController());
  Get.put(BookController());
  Get.put(AuthorController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Read Vault App',

      // Add builder here for ResponsiveFramework
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 600, name: MOBILE),
          const Breakpoint(start: 600, end: 900, name: TABLET),
          const Breakpoint(start: 900, end: 1200, name: DESKTOP),
          const Breakpoint(start: 1200, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: '/Welcome',
      getPages: [
        GetPage(name: '/Welcome', page: () => InitialScreen()),
        GetPage(name: '/Dashboard', page: () => HomeScreen()),
        GetPage(name: '/add-book', page: () => AddBookScreen()),
      ],
    );
  }
}
