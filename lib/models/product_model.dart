class ProductModel {
  final int id;
  final String title;
  final String description;
  final String images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      images: json["images"][0],
    );
  }
}
