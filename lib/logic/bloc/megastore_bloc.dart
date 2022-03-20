import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:megastore/data/models/explore_best_seller_model.dart';
import 'package:megastore/data/repositories/explore_best_seller_repository.dart';

part 'megastore_event.dart';
part 'megastore_state.dart';

class MegastoreBloc extends Bloc<MegastoreEvent, MegastoreState> {
  final ExploreBestSellerRepository exploreBestSellerRepository;

  MegastoreBloc({required this.exploreBestSellerRepository})
      : super(MegastoreInitial()) {
    on<MegastoreEvent>((event, emit) {});

    on<FetchBestSellerProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        final List<ExploreBestSellerModel> best_seller =
            await exploreBestSellerRepository.fetchBestSellerProducts();
        emit(ProductsLoaded(best_seller));
      } on NetworkError {
        emit(ProductsError());
      }
    });
  }
  void dispose() {}
  @override
  Future<void> close() {
    return super.close();
  }
}
