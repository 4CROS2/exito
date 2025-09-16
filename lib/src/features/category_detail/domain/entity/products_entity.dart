import 'package:exito/src/features/home/domain/entity/category_entity.dart';

/// ProductEntity representa un producto en la aplicación.
/// Contiene información básica del producto como id, título, imagen y calificación.
/// También incluye una clase anidada ProductRating para manejar la calificación del producto.
class ProductEntity extends CategoryEntity {
  ProductEntity({
    required this.id,
    required this.title,
    required this.rating,
    required this.price,
    required super.categoryName,
    required super.imageUrl,
  });

  final int id;
  final String title;
  final double price;
  final ProductRatingEntity rating;
}

class ProductRatingEntity {
  ProductRatingEntity({required this.rate, required this.count});

  final double rate;
  final int count;
}
