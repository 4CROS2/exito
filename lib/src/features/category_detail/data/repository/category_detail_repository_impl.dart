import 'package:exito/src/features/category_detail/data/model/product_model.dart';
import 'package:exito/src/features/category_detail/domain/datasource/category_detail_datasource.dart';
import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:exito/src/features/category_detail/domain/repository/category_detail_repository.dart';

/// Implementación concreta del repositorio de detalles de categoría.
///
/// Filtra los productos por categoría usando el datasource.
class ICategoryDetailRepository implements CategoryDetailRepository {
  ICategoryDetailRepository({required CategoryDetailDatasource datasource})
    : _datasource = datasource;
  final CategoryDetailDatasource _datasource;

  @override
  /// Obtiene los productos de una categoría específica.
  @override
  Future<List<ProductEntity>> getProductsByCategory({
    required String category,
  }) async {
    final List<Map<String, dynamic>> productsMap = await _datasource
        .getProducts();
    final List<ProductEntity> products = productsMap
        .map((Map<String, dynamic> map) => ProductModel.fromJson(map))
        .where((ProductEntity product) => product.categoryName == category)
        .toList();
    return products;
  }
}
