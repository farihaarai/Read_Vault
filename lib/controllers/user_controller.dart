import 'dart:convert';
import 'dart:ui_web';
import 'package:booklibraryflutter/controllers/base_api_controller.dart';
import 'package:booklibraryflutter/controllers/book_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';
import '../models/user.dart';

class UserController extends BaseApiController {
  final List<String> names = ["Akshada", "Pratik", "Fariha", "Arnold"];
  final RxList<User> users = <User>[].obs;

  final Rx<User?> currentUser = Rx<User?>(
    null,
  ); //final Rxn<User> currentUser = Rxn<User>();

  final RxString filter = "all".obs;
  final RxString query = "".obs;

  @override
  void onInit() {
    super.onInit();
    // final BookController bookController = Get.find();
    // loadBooks(currentUser.value!);
    Iterable<User> _users = names.map((name) {
      return User(name: name, books: []);
    });
    users.addAll(_users);

    currentUser.value = users.first;
    // if (users.isNotEmpty && currentUser.value != null) {
    //   Get.find<BookController>().loadBooks(currentUser.value!);
    // }
  }

  void selectUser(User u) {
    currentUser.value = u;

    // Load books for newly selected user
    Get.find<BookController>().loadBooks();
  }
}
