import 'package:equatable/equatable.dart';

class ExploreBestSellerModel extends Equatable {
  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;
  final int quantity;
  // final Object rating;

  const ExploreBestSellerModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    required this.quantity,

    // required this.rating,
  });

  factory ExploreBestSellerModel.fromJson(Map<String, dynamic> json) {
    return ExploreBestSellerModel(
      id: json['id'],
      title: json['title'],
      // price: "${json['price']}",
      price: double.parse("${json['price']}"),
      category: json['category'],
      description: json['description'],
      image: json['image'],
      quantity: 1,
      // rating: json['rating'],
    );
  }
  List<Object?> get props => [id, title, price, category, description, image,quantity];
}
