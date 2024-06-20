import 'package:firebase_authentication/screen/home/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutScreen extends StatelessWidget {
   CheckOutScreen({super.key,required this.totalPrice});

  final String totalPrice;
  final TextEditingController nameController=TextEditingController();
  final TextEditingController phoneController=TextEditingController();
  final TextEditingController addressController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(label: Text("Name"),border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 20,),
            TextField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(label: Text("Phone Number"),border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: addressController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(label: Text("Address"),border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(height: 40,),
            InkWell(
              onTap: () async {
                if(nameController.text.isNotEmpty&&phoneController.text.isNotEmpty&&addressController.text.isNotEmpty) {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove("cartItems");
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        "Order Placed.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )));
                }
                else{
                  if(nameController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Enter valid name",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )));
                  }
                  if(phoneController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Enter valid phone number",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )));
                  }
                  if(addressController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Enter valid address",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )));
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color:  Colors.green,
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.all(8),
                child:  Center(
                    child: Text(
                      "Place Order $totalPrice",
                      style: const TextStyle(
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
}
