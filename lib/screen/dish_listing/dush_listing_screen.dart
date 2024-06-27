import 'dart:convert';

import 'package:firebase_authentication/screen/loading_screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cart/cart.dart';

class DishListing extends StatelessWidget {
  DishListing({super.key, required this.title, required this.items});

  String title;
  List items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: Text(
            title,
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartView(),
                    ));
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.shopping_cart),
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            Map item = items[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.redAccent.shade700),
                child: InkWell(
                  onTap: () async {
                    loadingScreen(context);
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    String cart =
                        sharedPreferences.get("cartItems") as String? ?? "";
                    if (cart != "") {
                      List cartItems = jsonDecode(cart);
                      print("the cart items$cartItems");
                        cartItems.add(item);
                        sharedPreferences.setString("cartItems", jsonEncode(cartItems));
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.green,
                                content: Text(
                          "Added to cart.",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )));
                    } else {
                      sharedPreferences.setString("cartItems", jsonEncode([item]));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                          content: Text(
                            "Added to cart.",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          )));
                    }

                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(item["dish_name"],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                ),
                                const SizedBox(width: 20),
                                Text("INR ${item["dish_price"]}",
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
                            Text(item["dish_description"],
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
                          image: NetworkImage(item["dish_image"]),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
