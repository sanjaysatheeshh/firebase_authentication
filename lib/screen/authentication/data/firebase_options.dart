import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
        apiKey: "AIzaSyD9IJSr9IBkrx8WUofc42b9bvWxj1Q0DUo",
        authDomain: "project-authentication-fa168.firebaseapp.com",
        projectId: "project-authentication-fa168",
        storageBucket: "project-authentication-fa168.appspot.com",
        messagingSenderId: "272440339018",
        appId: "1:272440339018:web:3e6b44f10f309dbefa94b3",
        measurementId: "G-SZPD5E3KQG"
  );

  static const FirebaseOptions android =  FirebaseOptions(
      apiKey: "AIzaSyD9IJSr9IBkrx8WUofc42b9bvWxj1Q0DUo",
      authDomain: "project-authentication-fa168.firebaseapp.com",
      projectId: "project-authentication-fa168",
      storageBucket: "project-authentication-fa168.appspot.com",
      messagingSenderId: "272440339018",
      appId: "1:272440339018:web:3e6b44f10f309dbefa94b3",
      measurementId: "G-SZPD5E3KQG"
  );

  static const FirebaseOptions ios =  FirebaseOptions(
      apiKey: "AIzaSyD9IJSr9IBkrx8WUofc42b9bvWxj1Q0DUo",
      authDomain: "project-authentication-fa168.firebaseapp.com",
      projectId: "project-authentication-fa168",
      storageBucket: "project-authentication-fa168.appspot.com",
      messagingSenderId: "272440339018",
      appId: "1:272440339018:web:3e6b44f10f309dbefa94b3",
      measurementId: "G-SZPD5E3KQG"
  );

  static const FirebaseOptions macos =  FirebaseOptions(
      apiKey: "AIzaSyD9IJSr9IBkrx8WUofc42b9bvWxj1Q0DUo",
      authDomain: "project-authentication-fa168.firebaseapp.com",
      projectId: "project-authentication-fa168",
      storageBucket: "project-authentication-fa168.appspot.com",
      messagingSenderId: "272440339018",
      appId: "1:272440339018:web:3e6b44f10f309dbefa94b3",
      measurementId: "G-SZPD5E3KQG"
  );
  static const FirebaseOptions windows =  FirebaseOptions(
      apiKey: "AIzaSyD9IJSr9IBkrx8WUofc42b9bvWxj1Q0DUo",
      authDomain: "project-authentication-fa168.firebaseapp.com",
      projectId: "project-authentication-fa168",
      storageBucket: "project-authentication-fa168.appspot.com",
      messagingSenderId: "272440339018",
      appId: "1:272440339018:web:3e6b44f10f309dbefa94b3",
      measurementId: "G-SZPD5E3KQG"
  );
}
