class ProductsModel {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;
  final int categoryId;
  final int availability;

  ProductsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.availability,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      image: json["image"],
      description: json["description"],
      availability: json["availability"],
      categoryId: json["category_id"],
    );
  }
}