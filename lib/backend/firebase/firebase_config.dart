import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAR2wX6OsmsyrkoH7aTUFjDdP53Y0Cyw1E",
            authDomain: "krishi-45673.firebaseapp.com",
            projectId: "krishi-45673",
            storageBucket: "krishi-45673.firebasestorage.app",
            messagingSenderId: "107868149205",
            appId: "1:107868149205:web:4ffbb6aaa97cdbcf21595c",
            measurementId: "G-FZTSPVKEY6"));
  } else {
    await Firebase.initializeApp();
  }
}
