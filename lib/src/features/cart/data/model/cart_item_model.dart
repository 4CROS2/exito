import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';
import 'package:exito/src/features/category_detail/data/model/product_model.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.id,
    required super.title,
    required super.rating,
    required super.price,
    required super.categoryName,
    required super.imageUrl,
    required super.quantity,
  });

  factory CartItemModel.fromJson({required Map<String, dynamic> json}) {
    final Map<String, dynamic> ratingMap = Map<String, dynamic>.from(
      json['rating'] as Map<String, dynamic>,
    );
    final double price = double.parse(json['price'].toString());
    return CartItemModel(
      id: json['id'],
      title: json['title'] as String,
      rating: ProductRatingModel.fromJson(json: ratingMap),
      price: price,
      categoryName: json['categoryName'] as String,
      imageUrl: json['imageUrl'] as String,
      quantity: json['quantity'] as int,
    );
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      id: entity.id,
      title: entity.title,
      rating: entity.rating,
      price: entity.price,
      categoryName: entity.categoryName,
      imageUrl: entity.imageUrl,
      quantity: entity.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ratingMap = ProductRatingModel.fromEntity(
      super.rating,
    ).toJson();
    return <String, dynamic>{
      'id': id,
      'title': title,
      'rating': ratingMap,
      'price': price,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
