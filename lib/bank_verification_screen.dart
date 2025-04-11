import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smartie/login_screen.dart';

class BankVerifyScreen extends StatefulWidget {
  @override
  _BankVerifyScreenState createState() => _BankVerifyScreenState();
}

class _BankVerifyScreenState extends State<BankVerifyScreen> {

  String _text = 'We are verifying your bank details';
  int _dotCount = 0;
  late Timer _timer;

  @override
  void initState(){
    super.initState();

    //Delay for 3s
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => LoginScreen())
      );
    });

    // Loading dots animation
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4;
        _text = 'We are verifying your bank details' + '.' * _dotCount;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Align items at the start
              children: [
                // Company Icon
                Image.asset(
                  'assets/images/smartie_logo.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),

                Padding(padding: EdgeInsets.all(48.0)),
                
                Text(
                  _text,
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),

                 Padding(padding: EdgeInsets.all(24.0)),

                Text(
                  "Did you know?",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(0, 162, 233, 1),
                    ),
                  textAlign: TextAlign.center,
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 64.0, left: 36.0, right: 36.0),
                  child: Text(
                    "Did you know that by using SMARTI&E, you're joining the 49% of Canadians who seek financial advice to enhance their financial well-being?",
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 36.0, right: 36.0),
                  child: Text(
                    "You’re all set—let’s dive into your personalised affordability dashboard and take control of your financial future.",
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(padding: EdgeInsets.all(24.0)),

                !isVerified ?
                  Column(
                    children: [
                      Text(
                        "We are verifying your bank details.",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),

                      Padding(padding: EdgeInsets.all(4.0)),

                      LinearProgressIndicator(
                        value: _progressAnimation.value,
                        minHeight: 8,
                        backgroundColor: Colors.blue[100],
                        valueColor: AlwaysStoppedAnimation<Color>(const Color.fromRGBO(0, 162, 233, 1)),
                      )
                    ],
                  ) :

                  Column(
                    children: [
                      Text(
                        "The verification was successful!",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),

                      Padding(padding: EdgeInsets.all(4.0)),

                      SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 162, 233, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "Let's Go",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ],
                ),

                Padding(padding: EdgeInsets.all(64.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
