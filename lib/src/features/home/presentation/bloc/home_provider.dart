import 'package:exito/src/features/home/domain/entity/category_entity.dart';
import 'package:exito/src/features/home/domain/usecase/home_usecase.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({required HomeUsecase usecase}) : _usecase = usecase;
  final HomeUsecase _usecase;
  bool isLoading = false;
  String errorMessage = '';
  late List<CategoryEntity> _categories;

  void getCategories() async {
    try {
      isLoading = true;
      notifyListeners();
      _categories = await _usecase();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
