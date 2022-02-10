import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmc/Dashboard/screens/Dashboard.dart';
import 'package:tmc/LoginAndSignUp/controller/LoginController.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginData.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginResponse.dart';
import 'package:tmc/LoginAndSignUp/screens/RegisterPage.dart';
import 'package:tmc/constants/colors.dart';
import 'package:tmc/constants/buttonStyles.dart';
import 'package:tmc/constants/config.dart';
import 'package:tmc/screens/inputDecoration.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double height, width;

  String username = '';

  String password = '';

  var loginController;

  final double alertIconBoxheight = 40;

  final _formKey = GlobalKey<FormState>();

  FocusNode _emailFieldFocus = FocusNode();

  FocusNode _passwordFieldFocus = FocusNode();

  Color _emailColor = Colors.white;

  Color _emailLabelColor = Colors.grey;

  Color _passwordColor = Colors.white;

  Color _passwordLabelColor = Colors.grey;

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // getTokenFCM();
  }

  getTokenFCM() async {
    showCustomAlert("Token", "retriving");
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    Navigator.pop(context);
    print(token);
    showCustomAlert("Token", token);
  }

  showForgotPasswordDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Stack(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: alertIconBoxheight / 2),
                              child: Container(
                                color: white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          height: 10,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: alertIconBoxheight / 2 + 5, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Alert - Forgot Password?',
                                            style: TextStyle(
                                                color: colorSecondary, fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                              'An email will be sent to your registered email for changing your password!'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: alertIconBoxheight,
                              width: alertIconBoxheight * 2.5,
                              decoration: BoxDecoration(
                                color: colorSecondary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                  child: Image.asset(
                                "assets/images/alert.png",
                                height: alertIconBoxheight - 5,
                                width: alertIconBoxheight - 5,
                              )),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon: Icon(Icons.cancel_outlined, color: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

  showCustomAlert(String heading, String text) {
    print(text);
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrollable: true,
              alignment: Alignment.topCenter,
              contentPadding: EdgeInsets.zero,
              content: Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: alertIconBoxheight / 2),
                            child: Container(
                              color: white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        height: 10,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: alertIconBoxheight / 2 + 5, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          heading,
                                          style: TextStyle(
                                              color: colorSecondary, fontWeight: FontWeight.w300),
                                        ),
                                        Text(text),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: alertIconBoxheight,
                            width: alertIconBoxheight * 2.5,
                            decoration: BoxDecoration(
                              color: colorSecondary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                                child: Image.asset(
                              "assets/images/alert.png",
                              height: alertIconBoxheight - 5,
                              width: alertIconBoxheight - 5,
                            )),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: Icon(Icons.cancel_outlined, color: Colors.black),
                                onPressed: () {
                                  Navigator.pop(context);
                                })),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

  showLoaderDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrollable: true,
              alignment: Alignment.center,
              contentPadding: EdgeInsets.zero,
              content: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Center(
                        child: CircularProgressIndicator(),
                      )),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

  login() async {
    showLoaderDialog();
    if (_formKey.currentState!.validate()) {
      LoginResponse isAuthorized =
          await loginController.login(LoginData(username: username, password: password));
      if (isAuthorized.token == "no internet") {
        Navigator.pop(context);
        showCustomAlert('Uh oh, something went wrong! There is a problem with your request',
            isAuthorized.responseText);
      } else if (isAuthorized.token == 'null') {
        Navigator.pop(context);
        showCustomAlert('Alert - Invalid Credentials', isAuthorized.responseText);
        // print('Not Logged IN');
      } else {
        print("Token : ${isAuthorized.token}");
        setState(() {
          token = isAuthorized.token;
        });
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => new DashBoard(loginResponse: isAuthorized)),
            (route) => false);
      }
    } else {
      Navigator.pop(context);
      print("Username and password length must be atleast 4 characters. Please try again.");
      if (username.length <= 3 && password.length <= 3) {
        showCustomAlert('Alert - Invalid Credentials', "Invalid Username and Password!");
      } else if (username.length <= 3) {
        showCustomAlert('Alert - Invalid Credentials', "Invalid Username!");
      } else if (password.length <= 3) {
        showCustomAlert('Alert - Invalid Credentials', "Invalid Password!");
      }
      // showCustomFlushBar(context, "Enter Valid Username/Password !", 2);
    }
  }

  register(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    loginController = Provider.of<LoginController>(context);
    return Scaffold(
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
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
                fit: BoxFit.fill)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TRANSACTION MONITORING CENTER',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // email password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 22,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: TextFormField(
                                validator: (val) {
                                  return !(val!.length <= 3) ? null : "";
                                },
                                onChanged: (value) => username = value,
                                cursorColor: Colors.grey,
                                focusNode: _emailFieldFocus,
                                style: TextStyle(
                                  color: _emailLabelColor,
                                  fontSize: 18,
                                  fontFamily: 'Arvo',
                                ),
                                decoration: getInputDecoration(
                                    "Username",
                                    _emailColor,
                                    _emailLabelColor,
                                    Icon(
                                      Icons.person,
                                      size: 18,
                                      color: _emailLabelColor,
                                    ),
                                    null),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: TextFormField(
                                validator: (val) {
                                  if (val != null) {
                                    if (val.isEmpty) {
                                      return "";
                                    } else if (val.length <= 3) {
                                      return "";
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                                onChanged: (value) => password = value,
                                cursorColor: Colors.grey,
                                obscureText: _obscureText,
                                focusNode: _passwordFieldFocus,
                                style: TextStyle(
                                  color: _passwordLabelColor,
                                  fontSize: 18,
                                  fontFamily: 'Arvo',
                                ),
                                decoration: getInputDecoration(
                                    "Password",
                                    _passwordColor,
                                    _passwordLabelColor,
                                    Icon(
                                      Icons.lock,
                                      size: 18,
                                      color: _passwordLabelColor,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        icon: Icon(
                                          !_obscureText ? Icons.visibility : Icons.visibility_off,
                                          color: !_obscureText
                                              ? _passwordLabelColor
                                              : Colors.grey[500],
                                        ))),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: ElevatedButton(
                                    style: raisedButtonStyle,
                                    onPressed: () {
                                      register(context);
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: ElevatedButton(
                                    style: raisedButtonStyle,
                                    onPressed: () {
                                      login();
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     // showForgotPasswordDialog();
                            //     getTokenFCM();
                            //   },
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Text(
                            //         'Forgot Password? ',
                            //         style: TextStyle(color: login_blue),
                            //       ),
                            //       Text(
                            //         'Reset',
                            //         style: TextStyle(color: login_blue),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // ElevatedButton(
              //     onPressed: () {
              //       showDialog(
              //           context: context,
              //           builder: (context) {
              //             return AlertDialog(

              //               content: Container(
              //                 width: 800,
              //                 height: 300,
              //                 color: Colors.white,
              //                 child: Column(
              //                   children: [
              //                     Text('Alert'),
              //                   ],
              //                 ),
              //               ),
              //             );
              //             // return Container(
              //             //   width: 800,
              //             //   height: 300,
              //             //   color:Colors.white,
              //             //   child: Text('Alert'),
              //             // );
              //           });
              //     },
              //     child: Text('Continue'))
            ],
          ),
        ),
      ),
    );
  }
}
