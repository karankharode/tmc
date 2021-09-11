import 'package:flutter/material.dart';

import 'inputDecoration.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  late double height, width;

  String email = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();

  FocusNode _emailFieldFocus = FocusNode();
  FocusNode _passwordFieldFocus = FocusNode();

  Color _emailColor = Colors.white;
  Color _emailLabelColor = Colors.grey;
  Color _passwordColor = Colors.white;
  Color _passwordLabelColor = Colors.grey;

  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
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
                width: 200,
                child: Column(
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
                                // validator: (val) {
                                //   return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val) ||
                                //           RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                //                   r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                //                   r"{0,253}[a-zA-Z0-9])?)*$")
                                //               .hasMatch(val)
                                //       ? null
                                //       : "Please provide valid number or Email ID";
                                // },
                                onChanged: (value) => email = value,
                                cursorColor: Colors.grey,
                                focusNode: _emailFieldFocus,

                                style: TextStyle(
                                  color: _emailLabelColor,
                                  fontSize: 18,
                                  fontFamily: 'GothamMedium',
                                ),
                                decoration: getInputDecoration(
                                    "Email Address",
                                    _emailColor,
                                    _emailLabelColor,
                                    Icon(
                                      Icons.email,
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
                                // validator: (val) {
                                //   return RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*")
                                //           .hasMatch(val)
                                //       ? null
                                //       : "Input Valid Password";
                                // },
                                onChanged: (value) => password = value,
                                cursorColor: Colors.grey,
                                obscureText: _obscureText,
                                focusNode: _passwordFieldFocus,
                                style: TextStyle(
                                  color: _passwordLabelColor,
                                  fontSize: 18,
                                  fontFamily: 'GothamMedium',
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
                                        onPressed: () {},
                                        icon: Icon(
                                          !_obscureText ? Icons.visibility : Icons.visibility_off,
                                          color: !_obscureText
                                              ? _passwordLabelColor
                                              : Colors.grey[500],
                                        ))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () => {},
                              child: Row(
                                children: [
                                  Text(
                                    'Forgot Password ? ',
                                    style: TextStyle(color: white),
                                  ),
                                  Text(
                                    'Reset',
                                    style: TextStyle(color: white),
                                  ),
                                ],
                              ),
                            ),
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
