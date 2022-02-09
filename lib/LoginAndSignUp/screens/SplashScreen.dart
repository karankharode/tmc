import 'package:flutter/material.dart';
import 'package:tmc/Dashboard/screens/Dashboard.dart';
import 'package:tmc/LoginAndSignUp/controller/LoginController.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginResponse.dart';
import 'package:tmc/LoginAndSignUp/screens/LoginPage.dart';
import 'package:tmc/constants/config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  /// Setting duration in splash screen
  // startTime() async {
  //   return new Timer(Duration(milliseconds: 3000), NavigatorPage);
  // }
  checkLogin() async {
    final loginController = LoginController();

    var defaultPage;
    print("Checking login info...");
    bool isAuthorized = await loginController.isUserAuthorized();
    if (isAuthorized) {
      print("Login Info Found! Getting saved token...");
      LoginResponse loginResponse = await loginController.getSavedUserDetails();

      token = loginResponse.token;

      print("Saved Token : $token}\n");
      defaultPage = DashBoard(loginResponse: loginResponse);
    } else {
      print("No login info found! Please Enter username and password or register.");
      defaultPage = LoginPage();
    }
    Widget defaultHome = defaultPage;
    navigatorPage(defaultHome); // isAuthorized ? homePage : loginPage;
  }

  /// To navigate layout change
  void navigatorPage(startupPage) {
    Navigator.of(context)
        .pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => startupPage));
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.red,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 35, 2, 8),
            child: Image.asset(
              'assets/branding/atx_logo.png',
              height: 100,
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: _height,

        /// Set Background image in splash screen layout (Click to open code)
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
                fit: BoxFit.fill)),

        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
