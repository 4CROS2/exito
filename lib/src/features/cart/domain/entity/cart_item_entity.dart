import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';

class CartItemEntity extends ProductEntity {
  CartItemEntity({
    required super.id,
    required super.title,
    required super.rating,
    required super.price,
    required super.categoryName,
    required super.imageUrl,
    required this.quantity,
  });
  final int quantity;

  static CartItemEntity fromProductEntity(ProductEntity product, int quantity) {
    return CartItemEntity(
      id: product.id,
      title: product.title,
      rating: product.rating,
      price: product.price,
      categoryName: product.categoryName,
      imageUrl: product.imageUrl,
      quantity: quantity,
    );
  }
}
