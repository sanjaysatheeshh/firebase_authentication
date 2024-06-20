import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/screen/home/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "asset/images/firebase_logo.png",
                height: screenHeight / 3,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async{
                  final googleLogin =
                      await GoogleSignIn(forceCodeForRefreshToken: false,scopes: ['https://www.googleapis.com/auth/drive'],).signIn();
                  GoogleSignInAuthentication? googleSignInAuthentication =
                      await googleLogin?.authentication;
                  if(googleSignInAuthentication!=null){
                  final credential = GoogleAuthProvider.credential(
                      accessToken: googleSignInAuthentication.accessToken,
                      idToken: googleSignInAuthentication.idToken);
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithCredential(credential);
                  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
                  sharedPreference.setString("userName", userCredential.user?.displayName??"");
                  sharedPreference.setString("userImage", userCredential.user?.photoURL??"");
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                }},
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.only(
                      top: 14, bottom: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color:  Colors.red),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text("Login",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //         Text("Login",
              //             overflow: TextOverflow.ellipsis,
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w500,
              //             )),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
