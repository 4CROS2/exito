import 'package:exito/src/features/category_detail/domain/entity/products_entity.dart';
import 'package:exito/src/features/category_detail/domain/usecase/category_detail_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CategoryDetailProvider extends ChangeNotifier {
  CategoryDetailProvider({required CategoryDetailUsecase usecase})
    : _usecase = usecase;
  final CategoryDetailUsecase _usecase;
  Status _status = Status.initial;
  String _errorMessage = '';
  List<ProductEntity> products = <ProductEntity>[];
  Status get status => _status;
  String get message => _errorMessage;

  void loadProductsByCategory({required String category}) async {
    try {
      _status = Status.loading;
      notifyListeners();
      products = await _usecase.getProductsByCategory(category: category);
      _status = Status.success;
      notifyListeners();
    } catch (e) {
      _status = Status.error;
      _errorMessage = 'Error al cargar los productos: $e';
      notifyListeners();
    }
  }
}
