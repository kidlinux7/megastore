import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megastore/data/models/cart_model.dart';
import 'package:megastore/data/models/explore_best_seller_model.dart';
import 'package:megastore/logic/bloc/cart_bloc.dart';

class ProductDetails extends StatefulWidget {
  final ExploreBestSellerModel product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late final CartBloc cartBloc;
  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    cartBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    // final String price = widget.product.price;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black54,
        title: Text(
          "Product Details",
          textScaleFactor: 1.0,
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added product to cart')));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: deviceHeight * 0.4,
                    color: Colors.red,
                    child: Image.network(
                      "${widget.product.image}",
                      fit: BoxFit.contain,
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
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ("${widget.product.title}"),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 238, 220, 55),
                              size: 30.0,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            text: widget.product.description,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color.fromARGB(255, 53, 53, 53),
                                wordSpacing: 1)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.blue,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    var cartItem = CartProductModel(
                        // id: 1,
                        // title: 'widget.product.title',
                        // image: 'widget.product.image',
                        // price: 12,

                        id: widget.product.id,
                        title: widget.product.title,
                        image: widget.product.image,
                        price: widget.product.price,
                        quantity: widget.product.quantity);
                    cartBloc.add(CartProductAdded(cartproducts: cartItem));
                    // context
                    //     .read<CartBloc>()
                    //     .add(CartProductAdded(cartproducts: cartItem));
                  },
                  child: Text("Add to cart ${widget.product.price}/="),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
