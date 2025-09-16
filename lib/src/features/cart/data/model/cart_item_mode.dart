import 'package:exito/src/features/cart/domain/entity/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({required super.id, required super.quantity});

  //fromEntity
  factory CartItemModel.fromEntity(CartItemEntity entity) =>
      CartItemModel(id: entity.id, quantity: entity.quantity);

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      CartItemModel(id: json['id'] as int, quantity: json['quantity'] as int);

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'quantity': quantity,
  };
}
