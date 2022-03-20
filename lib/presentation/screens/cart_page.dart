import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwave/flutterwave.dart';
// import 'package:flutterwave/core/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:megastore/logic/bloc/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartBloc cartBloc;
  double totalValue = 0;
  String refKey = '';
  String checkoutTotal = '';

// Acts like a unique ID (This value should be generated from the server)
  void setRef() {
    Random rand = Random();
    int number = rand.nextInt(2000);
    if (Platform.isAndroid) {
      setState(() {
        refKey = "AndroidRef12433$number";
      });
    } else {
      setState(() {
        refKey = "iOSRef14553$number";
      });
    }
  }

  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    // cartTotalPrice();
    setRef();
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
              checkoutTotal = (totalValue).toString();
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
                Padding(
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
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: (() {
                      chechout(context, checkoutTotal);
                    }),
                    child: Container(
                      width: deviceWidth,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 151, 151, 151),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Checkout",
                                textScaleFactor: 1.3,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
                                size: 25.0,
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

  chechout(BuildContext context, String checkoutTotal) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
          context: this.context,
          encryptionKey: "FLWSECK_TEST45496b6b4694",
          publicKey: "FLWPUBK_TEST-44f95e3900d8a763f7154fd624fc65b3-X",
          currency: "NGN",
          amount: checkoutTotal,
          email: "princeherman08@gmail.com",
          fullName: "Prince Herman Mutungi",
          txRef: refKey,
          isDebugMode: true,
          phoneNumber: "+255716241549",
          acceptCardPayment: true,
          acceptUSSDPayment: false,
          acceptAccountPayment: false,
          acceptFrancophoneMobileMoney: false,
          acceptGhanaPayment: false,
          acceptMpesaPayment: true,
          acceptRwandaMoneyPayment: false,
          acceptUgandaPayment: false,
          acceptZambiaPayment: false);

      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();

      if (response == null) {
        // print(response.message);
        // print(response.status);
        print('Transaction Failed');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Transaction was not successful"),
          backgroundColor: Colors.red,
        ));
      } else {
        if (response.status == 'success') {
          print(response.message);
          print(response.status);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Transaction was successful"),
            backgroundColor: Colors.green,
          ));
        }
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }
}
