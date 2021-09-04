import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
            children: [
              Text(
                'TRANSACTION MONITORING CENTER',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              width: 800,
                              height: 300,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Text('Alert'),
                                ],
                              ),
                            ),
                          );
                          // return Container(
                          //   width: 800,
                          //   height: 300,
                          //   color:Colors.white,
                          //   child: Text('Alert'),
                          // );
                        });
                  },
                  child: Text('Continue'))
            ],
          ),
        ),
      ),
    );
  }
}
