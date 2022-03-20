import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:megastore/data/api/api_url.dart';
import 'package:megastore/data/models/explore_best_seller_model.dart';

class ExplorerBestSellerDataProvider {
  final _baseUrl = ApiUrl.best_seller_products_url;
  final successCode = 200;

  Future<List<ExploreBestSellerModel>> fetchBestSellerProducts() async {
    var url = Uri.parse(_baseUrl);
    var response = await http.get(url);
    List<ExploreBestSellerModel> best_seller_products = [];

    if (response.statusCode == successCode) {
      var json = jsonDecode(response.body);

      for (var resp in json) {
        // print(resp);
        var best_seller = ExploreBestSellerModel(
          id: resp['id'],
          title: resp['title'],
          price: double.parse("${resp['price']}"),
          category: resp['category'],
          description: resp['description'],
          image: resp['image'],
          quantity: 1,
        );
        best_seller_products.add(best_seller);
      }
      return best_seller_products;
    } else {
      throw response.statusCode;
    }
  }
}
