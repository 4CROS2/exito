import 'package:exito/src/features/home/domain/entity/category_entity.dart';
import 'package:exito/src/features/home/domain/repository/home_repository.dart';

class IHomeRepository implements HomeRepository {
  IHomeRepository();
  
  @override
  Future<List<CategoryEntity>> getCategories() {
    throw UnimplementedError();
  }
}
