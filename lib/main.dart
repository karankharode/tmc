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
          apiKey: "AIzaSyD5pvov9erS5PSJrnM1OQq_lnoKi0EUAUQ",
          authDomain: "doodledesk-184de.firebaseapp.com",
          projectId: "doodledesk-184de",
          storageBucket: "doodledesk-184de.appspot.com",
          messagingSenderId: "368195722051",
          appId: "1:368195722051:web:4fd80d1b6d70e8827b2df6",
          measurementId: "G-31ZYFG3CHJ"));
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
