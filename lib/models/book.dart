class Book {
  int id;
  String name;
  String author;
  String description;
  bool isFavorite;

  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    this.isFavorite = false,
  });
}
