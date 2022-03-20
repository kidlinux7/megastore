part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

// On loading provide an empty list of cart
class CartStarted extends CartEvent {
  final List<CartProductModel> cartproducts;
  const CartStarted({this.cartproducts = const <CartProductModel>[]});
  @override
  List<Object> get props => [cartproducts];
}

class CartProductAdded extends CartEvent {
  final CartProductModel cartproducts;
  const CartProductAdded({required this.cartproducts});
  @override
  List<Object> get props => [cartproducts];
}

class CartFormat extends CartEvent {}

class CartProductRemoved extends CartEvent {
  final int index;
  const CartProductRemoved({required this.index});
  @override
  List<Object> get props => [index];
}
