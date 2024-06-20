import 'dart:convert';

import 'package:firebase_authentication/screen/checkout_screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dish_listing/dush_listing_screen.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  Future<List> getCartItems() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String cartData = sharedPreferences.get("cartItems") as String? ?? "";
    if (cartData != "") {
      List cartItems = jsonDecode(cartData);
      return cartItems;
    } else {
      return [];
    }
  }

  Future<String> getItemPrice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String cartData = sharedPreferences.get("cartItems") as String? ?? "";
    print("object$cartData");
    if (cartData != "") {
      print("here");
      List cartItems = jsonDecode(cartData);
      double totalAmount = 0;
      for (Map element in cartItems) {
        totalAmount = totalAmount + element["dish_price"];
      }
      return totalAmount.toString();
    } else {
      return "0.0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            )),
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getCartItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data?.length != 0) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          snapshot.data!.removeAt(index);
                          sharedPreferences.setString(
                              "cartItems", jsonEncode(snapshot.data!));
                          setState(() {});
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Item Removed")));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.redAccent.shade700),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              snapshot.data![index]
                                                  ["dish_name"],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                            "INR ${snapshot.data![index]["dish_price"]}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400)),
                                        SizedBox(width: 20),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        snapshot.data![index]
                                            ["dish_description"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300)),
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image(
                                  image: NetworkImage(
                                      snapshot.data![index]["dish_image"]),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("No Items in Cart"),
                  );
                }
              },
            ),
          ),
          FutureBuilder(
              future: getItemPrice(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("Total Amount"),
                            Spacer(),
                            Text("${snapshot.data}"),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () async {
                            if (snapshot.data != (0.0).toString()) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutScreen(totalPrice: snapshot.data!),));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: snapshot.data == (0.0).toString()
                                    ? Colors.grey
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                                child: Text(
                              "Checkout",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.white),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                );
                }
                else{
                  return Container(
                    decoration: BoxDecoration(
                        color: snapshot.data == (0.0).toString()
                            ? Colors.grey
                            : Colors.green,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                  );
                }
              })
        ],
      ),
    );
  }
}
