import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmc/LoginAndSignUp/controller/LoginController.dart';
import 'package:tmc/LoginAndSignUp/screens/LoginPage.dart';
import 'package:tmc/constants/colors.dart';
import 'package:tmc/constants/buttonStyles.dart';
import 'package:tmc/screens/inputDecoration.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double height, width;

  String username = '';

  String confirmUsername = '';

  String password = '';

  String confirmPassword = '';

  final _formKey = GlobalKey<FormState>();

  var signUpController;

  FocusNode _emailFieldFocus = FocusNode();

  FocusNode _passwordFieldFocus = FocusNode();

  Color _emailColor = Colors.white;

  Color _emailLabelColor = Colors.grey;

  Color _passwordColor = Colors.white;

  Color _passwordLabelColor = Colors.grey;

  bool _obscureText = true;

  final double alertIconBoxheight = 40;

  showRegisteredDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.0),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              scrollable: true,
              alignment: Alignment.topCenter,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              content: Container(
                // height: MediaQuery.of(context).size.height,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Successfully registered! Please log in with registered username and password.',
                        style: TextStyle(color: Color(0xff95FF85)),
                      ),
                    ],
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

  showCustomAlert(String heading, String text) {
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

  doSignUp() async {
    showLoaderDialog();
    if (_formKey.currentState!.validate()) {
      String isAuthorized = await signUpController.signup(username, password);

      print(isAuthorized.toString());
      if (isAuthorized != "Error") {
        if (isAuthorized == "Successful registration") {
          Navigator.of(context)
              .pushReplacement(PageRouteBuilder(pageBuilder: (_, __, ___) => new LoginPage()));
          showRegisteredDialog();
        } else if (isAuthorized == "Username already Exists !") {
          Navigator.pop(context);
          showCustomAlert(
              "Alert - Invalid Registration!", "Uername already exists. Please try again.");
        }
      } else {
        Navigator.pop(context);
        showCustomAlert("Alert - Invalid Registration!", "Unknown error occured!");
      }
    } else {
      Navigator.pop(context);
      showCustomAlert("Alert - Invalid Registration!",
          "Uername and password has to be more than 3 characters. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    signUpController = Provider.of<LoginController>(context);
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
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: TextFormField(
                                validator: (val) {
                                  return val!.isNotEmpty ? null : "Please provide valid username";
                                },
                                onChanged: (value) => username = value,
                                cursorColor: Colors.grey,
                                focusNode: _emailFieldFocus,
                                style: TextStyle(
                                  color: _emailLabelColor,
                                  fontSize: 18,
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
                                      return "Please enter a valid password";
                                    } else if (val.length <= 3) {
                                      return "Password must contain 3 characters";
                                    } else {
                                      return null;
                                    }
                                    // return RegExp("^(?=.{8,32}\$)(?=.*[a-z])(?=.*[0-9]).*")
                                    //         .hasMatch(val)
                                    //     ? null
                                    //     : "Password must contain a letter, number & symbol";
                                  }
                                },
                                onChanged: (value) => password = value,
                                cursorColor: Colors.grey,
                                obscureText: _obscureText,
                                focusNode: _passwordFieldFocus,
                                style: TextStyle(
                                  color: _passwordLabelColor,
                                  fontSize: 18,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: TextFormField(
                                validator: (val) {
                                  return val == username ? null : "Username does not match";
                                },
                                onChanged: (value) => confirmUsername = value,
                                cursorColor: Colors.grey,
                                style: TextStyle(
                                  color: _emailLabelColor,
                                  fontSize: 18,
                                ),
                                decoration: getInputDecoration(
                                    "Confirm Username",
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
                                  return val == password ? null : "Password does not match";
                                },
                                onChanged: (value) => confirmPassword = value,
                                cursorColor: Colors.grey,
                                obscureText: _obscureText,
                                style: TextStyle(
                                  color: _passwordLabelColor,
                                  fontSize: 18,
                                ),
                                decoration: getInputDecoration(
                                    "Confirm Password",
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
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton(
                                    style: raisedButtonStyle,
                                    onPressed: () {
                                      doSignUp();
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton(
                                    style: raisedButtonStyle,
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => LoginPage()));
                                    },
                                    child: Text(
                                      'Back to Login',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
