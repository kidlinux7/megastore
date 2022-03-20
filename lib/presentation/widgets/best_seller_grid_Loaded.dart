import 'package:flutter/material.dart';
import 'package:megastore/data/models/explore_best_seller_model.dart';
import 'package:megastore/presentation/screens/product_details.dart';

Widget bestsellergridloaded({required BuildContext context, bestProductsList}) {
  return GridView.count(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2,
      children: List.generate(
        bestProductsList.length,
        (index) => InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProductDetails(product: bestProductsList[index])),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 400.0,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 90.0,
                      color: Colors.red,
                      child: Image.network(
                        "${bestProductsList[index].image}",
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : Container(
                                  color: Colors.white,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ("Tsh " + "${bestProductsList[index].price}"),
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            ("${bestProductsList[index].category}"),
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            ("${bestProductsList[index].title}"),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
}
