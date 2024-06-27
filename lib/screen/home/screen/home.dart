import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screen/authentication/screen/login.dart';
import 'package:firebase_authentication/screen/cart/cart.dart';
import 'package:firebase_authentication/screen/dish_listing/dush_listing_screen.dart';
import 'package:firebase_authentication/screen/home/function/function.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getUserDetails()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Object? userName= sharedPreferences.get("userName");
    Object? userImage= sharedPreferences.get("userImage");
    return {"userName":userName,"userImage":userImage};
  }
  Future getDishesList() async {
    try {
      Response response = await Dio()
          .get("http://run.mocky.io/v3/eed9349e-db58-470c-ae8c-a12f6f46c207",
          options: Options(headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          }));
      List tableMenuList = response.data[0]["table_menu_list"];
      return tableMenuList;
    } catch (e) {
      print("this has error$e");
      return Error();
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width / 3),
            color: Colors.white,
            child: FutureBuilder(
                future: getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(height: 60),
                        if (snapshot.data["userImage"] != null)
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                snapshot.data["userImage"],
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              )),
                        const SizedBox(height: 20),
                        if (snapshot.data["userName"] != null)
                          Text(snapshot.data["userName"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18)),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: InkWell(
                            onTap: () async {
                              await GoogleSignIn().signOut();
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
                            },
                            child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.only(top: 14, bottom: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.red),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text("Logout",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: 60),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: InkWell(
                            onTap: () async {
                              await GoogleSignIn().signOut();
                              await FirebaseAuth.instance.signOut();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 14, bottom: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.red),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text("Logout",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 20,
              )),
          actions:  [InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartView(),));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.shopping_cart),
            ),
          )],
        ),
        body: FutureBuilder(
          future: getDishesList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              print(snapshot.data);
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 5),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DishListing(
                                  title: snapshot.data[index]["menu_category"],
                                  items: snapshot.data[index]
                                      ["category_dishes"]),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.deepOrangeAccent.shade700),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data[index]["menu_category"]
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No Data Found",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              );
            }
          },
        ),
      ),
    );
  }
}
