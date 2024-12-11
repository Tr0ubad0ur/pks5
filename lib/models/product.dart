class Product {
  final int id;
  final String title;
  final String description;
  final String photo;
  final int price;
  bool isFavorite;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.photo,
    required this.price,
    this.isFavorite = false,
    this.quantity = 0,
  });
}