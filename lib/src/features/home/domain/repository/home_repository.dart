import 'package:exito/src/features/home/domain/entity/category_entity.dart';

abstract interface class HomeRepository {
  Future<List<CategoryEntity>> getCategories();
}
