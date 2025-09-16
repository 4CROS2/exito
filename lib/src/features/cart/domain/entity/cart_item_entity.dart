import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';

/// Entidad que representa un producto dentro del carrito de compras.
///
/// Extiende ProductEntity y añade la cantidad seleccionada.
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

  /// Cantidad de este producto en el carrito.
  final int quantity;

  /// Crea una instancia de CartItemEntity a partir de un ProductEntity y una cantidad.
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
