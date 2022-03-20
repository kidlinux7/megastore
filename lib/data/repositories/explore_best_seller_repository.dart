import 'package:megastore/data/dataproviders/explore_best_seller_data_provider.dart';
import 'package:megastore/data/models/explore_best_seller_model.dart';

class ExploreBestSellerRepository {
  final ExplorerBestSellerDataProvider explorerBestSellerDataProvider =
      ExplorerBestSellerDataProvider();

  Future<List<ExploreBestSellerModel>> fetchBestSellerProducts() async {
    return await explorerBestSellerDataProvider.fetchBestSellerProducts();
  }
}

class NetworkError extends Error {}
