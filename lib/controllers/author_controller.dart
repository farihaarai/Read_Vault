import 'dart:convert';

import 'package:booklibraryflutter/controllers/base_api_controller.dart';
import 'package:booklibraryflutter/models/author.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthorController extends BaseApiController {
  final RxList<Author> authors = <Author>[].obs;
  final RxInt selectedAuthorId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAuthors(); // API call when controller is created
  }

  // get authors API
  Future<void> loadAuthors() async {
    final url = Uri.parse('$baseUrl/authors');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      authors.value = data.map((json) => Author.fromJson(json)).toList();
      // if (authors.isNotEmpty) {
      //   // set first author as default
      //   selectedAuthorId.value = authors.first.id;
      // }
    } else {
      print("Failed to load authors: ${response.statusCode}");
    }
  }
}
