class ProductModel {
  String? id;
  String name;
  bool purchased;
  String imageUrl;

  ProductModel({
    this.id,
    required this.name,
    required this.purchased,
    required this.imageUrl,
  });

  ProductModel copyWith({String? name, bool? purchased, String? imageUrl}) =>
      ProductModel(
        name: name ?? this.name,
        purchased: purchased ?? this.purchased,
        imageUrl: this.imageUrl,
      );

  factory ProductModel.fromJson(String id, Map<String, dynamic> json) =>
      ProductModel(
          id: id,
          name: json["name"],
          purchased: json["purchased"],
          imageUrl: json["imageUrl"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "purchased": purchased,
        "imageUrl": imageUrl,
      };
}
