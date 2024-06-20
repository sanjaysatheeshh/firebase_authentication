import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screen/authentication/screen/login.dart';
import 'package:firebase_authentication/screen/home/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value){
      if(FirebaseAuth.instance.currentUser==null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }
    });
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(80),
        child: Lottie.asset("asset/lottie.json",fit: BoxFit.fitWidth),
      ),
    );
  }
}
