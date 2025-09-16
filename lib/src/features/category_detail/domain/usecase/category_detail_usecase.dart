import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:exito/src/features/category_detail/domain/repository/category_detail_repository.dart';

class CategoryDetailUsecase {
  const CategoryDetailUsecase({required CategoryDetailRepository repository})
    : _repository = repository;
  final CategoryDetailRepository _repository;

  Future<List<ProductEntity>> getProductsByCategory({
    required String category,
  }) async {
    return _repository.getProductsByCategory(category: category);
  }
}
