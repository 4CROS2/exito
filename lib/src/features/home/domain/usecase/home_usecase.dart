import 'package:exito/src/features/home/domain/entity/category_entity.dart';
import 'package:exito/src/features/home/domain/repository/home_repository.dart';

class HomeUsecase {
  const HomeUsecase({required HomeRepository repository})
    : _repository = repository;

  final HomeRepository _repository;
  Future<List<CategoryEntity>> call() {
    return _repository.getCategories();
  }
}
