import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:megastore/logic/bloc/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartBloc cartBloc;
  double totalValue = 0;

  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    // cartTotalPrice();
    super.initState();
  }

  @override
  void dispose() {
    cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        // centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                cartBloc.add(CartFormat());
              },
              icon: Icon(Icons.delete))
        ],
        foregroundColor: Color.fromARGB(137, 0, 0, 0),
        title: Text("My Cart",
            textScaleFactor: 1.0,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 0, 0, 0))),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<CartBloc, CartState>(
        bloc: cartBloc,
        builder: (context, state) {
          if (state is CartEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_rounded,
                    size: 100.0,
                    color: Colors.grey,
                  ),
                  Text(
                    'Empty Cart',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            );
          } else if (state is CartLoaded) {
            totalValue = 0;
            for (int x = 0; x < state.cartproducts.length; x++) {
              totalValue += (state.cartproducts[x].price *
                  state.cartproducts[x].quantity);
            }

            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.cartproducts.length,
                    itemBuilder: (BuildContext context, index) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 90.0,
                              color: Colors.red,
                              child: Image.network(
                                "${state.cartproducts[index].image}",
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
                            // Text(
                            //   '${state.cartproducts[index].title}',
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 1,
                            // ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (state.cartproducts[index].quantity >
                                          1) {
                                        setState(() {
                                          state.cartproducts[index].quantity--;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.remove_circle)),
                                Text(
                                  '${state.cartproducts[index].quantity}',
                                  textScaleFactor: 1.2,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        state.cartproducts[index].quantity++;
                                      });
                                    },
                                    icon: Icon(Icons.add_circle)),
                              ],
                            ),
                            Text(
                                '${state.cartproducts[index].price * state.cartproducts[index].quantity}'),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    state.cartproducts.removeWhere((element) =>
                                        element.id ==
                                        state.cartproducts[index].id);
                                  });
                                  if (state.cartproducts.isEmpty) {
                                    cartBloc.add(CartFormat());
                                  }
                                  // cartBloc.add(CartProductRemoved(
                                  //     index: state.cartproducts[index].id));
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  color: Color.fromARGB(255, 122, 122, 122),
                                ))
                          ],
                        ),
                      ));
                    }),
                state.cartproducts == null || state.cartproducts.length == 0
                    ? Center()
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          // onTap: cartTotalPrice,
                          child: Container(
                            width: deviceWidth,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "$totalValue",
                                      textScaleFactor: 1.7,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            );
          } else {
            return Center(child: Text('Something Went Wrong'));
          }
        },
      ),
    );
  }
}
