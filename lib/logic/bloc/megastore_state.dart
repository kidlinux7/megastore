part of 'megastore_bloc.dart';

abstract class MegastoreState extends Equatable {
  const MegastoreState();

  @override
  List<Object> get props => [];
}

class MegastoreInitial extends MegastoreState {}

class ProductsLoading extends MegastoreState {}

class ProductsLoaded extends MegastoreState {
  final List<ExploreBestSellerModel> best_seller;
  const ProductsLoaded(this.best_seller);
  @override
  List<Object> get props => [best_seller];
}

class ProductsError extends MegastoreState {}
