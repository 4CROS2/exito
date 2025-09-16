import 'package:exito/src/features/home/data/model/category_model.dart';
import 'package:exito/src/features/home/domain/datasource/home_datasource.dart';
import 'package:exito/src/features/home/domain/repository/home_repository.dart';

class IHomeRepository implements HomeRepository {
  IHomeRepository({required HomeDatasource datasource})
    : _datasource = datasource;
  final HomeDatasource _datasource;
  @override
  Future<List<CategoryModel>> getCategories() async {
    final List<Map<String, dynamic>> response = await _datasource
        .getCategories();

    // Usamos un Map para evitar duplicados: key = categoría
    final Map<String, CategoryModel> grouped = <String, CategoryModel>{};

    for (final Map<String, dynamic> category in response) {
      final CategoryModel model = CategoryModel.fromJson(json: category);

      // si ya existe la categoría, puedes decidir si reemplazar o mantener el primero
      grouped[model.name] = model;
    }

    // devolvemos solo los valores únicos
    return grouped.values.toList();
  }
}
