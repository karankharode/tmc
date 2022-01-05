import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmc/LoginAndSignUp/controller/LoginController.dart';
import 'package:tmc/LoginAndSignUp/screens/LoginPage.dart';

void main() {
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
