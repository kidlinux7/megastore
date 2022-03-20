import 'package:equatable/equatable.dart';

class CartProductModel extends Equatable {
  final int id;
  final String title;
  final double price;
  final String image;
  int quantity;

  CartProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  CartProductModel copyWith({
    int? id,
    String? title,
    double? price,
    String? image,
    int? quantity,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  List<Object?> get props => [id, title, price, image, quantity];
}
