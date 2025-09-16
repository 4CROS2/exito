import 'package:exito/src/features/home/domain/entity/category_entity.dart';

/// ProductEntity representa un producto en la aplicación.
/// Contiene información básica del producto como id, título, imagen y calificación.
/// También incluye una clase anidada ProductRating para manejar la calificación del producto.
/// Entidad que representa un producto en la aplicación.
///
/// Contiene información básica del producto como id, título, imagen y calificación.
class ProductEntity extends CategoryEntity {
  ProductEntity({
    required this.id,
    required this.title,
    required this.rating,
    required this.price,
    required super.categoryName,
    required super.imageUrl,
  });

  /// Identificador único del producto.
  final int id;

  /// Título o nombre del producto.
  final String title;

  /// Precio del producto.
  final double price;

  /// Calificación del producto.
  final ProductRatingEntity rating;
}

/// Entidad que representa la calificación de un producto.
class ProductRatingEntity {
  ProductRatingEntity({required this.rate, required this.count});

  /// Valor de la calificación (ej: 4.5 estrellas).
  final double rate;

  /// Número de personas que calificaron.
  final int count;
}
