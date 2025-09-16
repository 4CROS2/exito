import 'package:exito/src/features/category_detail/data/model/product_model.dart';
import 'package:exito/src/features/category_detail/domain/datasource/category_detail_datasource.dart';
import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:exito/src/features/category_detail/domain/repository/category_detail_repository.dart';

class ICategoryDetailRepository implements CategoryDetailRepository {
  ICategoryDetailRepository({required CategoryDetailDatasource datasource})
    : _datasource = datasource;
  final CategoryDetailDatasource _datasource;

  @override
  Future<List<ProductEntity>> getProductsByCategory({
    required String category,
  }) async {
    final List<Map<String, dynamic>> productsMap = await _datasource
        .getProducts();
    final List<ProductEntity> products = productsMap
        .map((Map<String, dynamic> map) => ProductModel.fromMap(map))
        .where((ProductEntity product) => product.categoryName == category)
        .toList();
    return products;
  }
}
