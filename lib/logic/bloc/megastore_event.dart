part of 'megastore_bloc.dart';

abstract class MegastoreEvent extends Equatable {
  const MegastoreEvent();

  @override
  List<Object> get props => [];
}

class FetchBestSellerProducts extends MegastoreEvent {
  const FetchBestSellerProducts();
}
