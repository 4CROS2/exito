import 'package:exito/src/features/home/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.categoryName, required super.imageUrl});
  factory CategoryModel.fromJson({required Map<String, dynamic> json}) {
    return CategoryModel(
      categoryName: json['category'] as String,
      imageUrl: json['image'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'category': categoryName, 'image': imageUrl};
  }
}
