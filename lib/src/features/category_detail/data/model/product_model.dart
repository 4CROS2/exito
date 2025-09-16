import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.rating,
    required super.price,
    required super.categoryName,
    required super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    try {
      final Map<String, dynamic> ratingMap = Map<String, dynamic>.from(
        map['rating'] as Map<String, dynamic>,
      );
      final double price = double.parse(map['price'].toString());
      return ProductModel(
        id: map['id'],
        title: map['title'],
        rating: ProductRatingModel.fromJson(json: ratingMap),
        price: price,
        categoryName: map['category'],
        imageUrl: map['image'],
      );
    } catch (e) {
      rethrow;
    }
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      title: entity.title,
      rating: entity.rating,
      price: entity.price,
      categoryName: entity.categoryName,
      imageUrl: entity.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    final ProductRatingModel rating = ProductRatingModel.fromEntity(
      this.rating,
    );
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': imageUrl,
      'rating': rating.toJson(),
      'price': price,
      'category': categoryName,
    };
  }
}

class ProductRatingModel extends ProductRatingEntity {
  ProductRatingModel({required super.rate, required super.count});

  factory ProductRatingModel.fromJson({required Map<String, dynamic> json}) {
    return ProductRatingModel(
      rate: double.parse(json['rate'].toString()),
      count: json['count'] ?? 0,
    );
  }

  factory ProductRatingModel.fromEntity(ProductRatingEntity entity) {
    return ProductRatingModel(rate: entity.rate, count: entity.count);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'rate': rate, 'count': count};
  }
}
