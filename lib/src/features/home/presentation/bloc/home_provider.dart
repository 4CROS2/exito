import 'package:exito/src/features/home/domain/entity/category_entity.dart';
import 'package:exito/src/features/home/domain/usecase/home_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class HomeProvider extends ChangeNotifier {
  List<CategoryEntity> _categories = <CategoryEntity>[];
  HomeProvider({required HomeUsecase usecase}) : _usecase = usecase;
  final HomeUsecase _usecase;
  Status status = Status.initial;
  String errorMessage = '';

  List<CategoryEntity> get categories => _categories;

  void getCategories() async {
    try {
      status = Status.loading;
      notifyListeners();
      _categories = await _usecase();
      status = Status.success;
      notifyListeners();
    } catch (e) {
      status = Status.error;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
