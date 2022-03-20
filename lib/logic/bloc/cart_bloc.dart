import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:megastore/data/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartEmpty()) {
    on<CartStarted>(_onCartStarted);
    on<CartProductAdded>(_onCartProductAdded);
    on<CartProductRemoved>(_onCartProductRemoved);
    on<CartFormat>(_onCartFormat);
  }

  void _onCartFormat(CartFormat event, Emitter<CartState> emit) {
    final state = this.state;
    emit(CartEmpty());
  }

  void _onCartStarted(CartStarted event, Emitter<CartState> emit) {
    emit(CartLoaded(cartproducts: event.cartproducts));
  }

  void _onCartProductAdded(CartProductAdded event, Emitter<CartState> emit) {
    final state = this.state;

    if (state is CartLoaded) {
      // print(state.cartproducts);
      print("=-=-=-=-=-=-=-=-=-=");
      // print(event.cartproducts.title);
      

      var contain = state.cartproducts
          .where((element) => element.title == event.cartproducts.title);
      // if (contain == true) {
      print(contain);
      emit(CartLoaded(
          cartproducts: List.from(state.cartproducts)
            ..add(event.cartproducts)));
      // } else {
      //   print('Product exists');
      // }

    } else {
      emit(CartLoaded(cartproducts: [event.cartproducts]));
    }
  }

  void _onCartProductRemoved(
      CartProductRemoved event, Emitter<CartState> emit) {
    final state = this.state;

    // emit(CartItemDelete(
    //     cartproducts: List.from(state)..add(event.cartproducts)));
  }

  void dispose() {}
}
