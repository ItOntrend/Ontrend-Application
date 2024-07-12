class GroceryCategoryModel {
  String image;
  String name;

  GroceryCategoryModel({required this.image, required this.name});

  factory GroceryCategoryModel.fromJson(Map<String, dynamic> json) {
    return GroceryCategoryModel(
      image: json['image'] ?? '', // Provide default empty string if null
      name: json['name'] ?? '', // Provide default empty string if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
    };
  }
}
