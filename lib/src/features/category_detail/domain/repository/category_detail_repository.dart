import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';

/// Clase abstracta que define el contrato para la fuente de datos de detalles de categoría.
/// Proporciona un método para obtener productos por categoría.
abstract interface class CategoryDetailRepository {
  Future<List<ProductEntity>> getProductsByCategory({required String category});
}
