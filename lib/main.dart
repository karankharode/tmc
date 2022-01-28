import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmc/LoginAndSignUp/controller/LoginController.dart';
import 'package:tmc/LoginAndSignUp/screens/LoginPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAAdqp4ACoyVRHaQ8sPnpIrWJZqKDz0eCQ",
          authDomain: "atx-tmc.firebaseapp.com",
          databaseURL: "https://atx-tmc-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "atx-tmc",
          storageBucket: "atx-tmc.appspot.com",
          messagingSenderId: "348686832653",
          appId: "1:348686832653:web:863ab72a483fe312383144",
          measurementId: "G-97Y01Z0SYF"));
  runApp(MultiProvider(
    providers: [
      Provider<LoginController>(create: (_) => LoginController()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMC',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arvo'),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
