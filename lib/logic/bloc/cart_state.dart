part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartEmpty extends CartState {}

class CartLoaded extends CartState {
  final List<CartProductModel> cartproducts;
  const CartLoaded({this.cartproducts = const <CartProductModel>[]});
  @override
  List<Object> get props => [cartproducts];
}

class CartItemDelete extends CartState {
  final List<CartProductModel> cartproducts;
  const CartItemDelete({required this.cartproducts});
}

class CartError extends CartState {
  @override
  List<Object> get props => [];
}
