import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smartie/login_screen.dart';


class BankVerifyScreen extends StatefulWidget {
  @override
  _BankVerifyScreenState createState() => _BankVerifyScreenState();
}

class _BankVerifyScreenState extends State<BankVerifyScreen> with TickerProviderStateMixin {
  bool isVerified = false;
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    super.initState();

    // Initialize the AnimationController with the TickerProviderStateMixin
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addListener(() {
        setState(() {});  // Rebuild the widget whenever the animation value changes
      })
      ..repeat();  // This makes the animation repeat indefinitely without reversing

    // After 5 seconds, mark as verified
    Timer(Duration(seconds: 5), () {
      setState(() {
        isVerified = true;
      });
    });

    // Initialize the progress animation to animate from 0.0 to 1.0
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    // After 5 seconds, mark as verified
    Timer(Duration(seconds: 5), () {
      setState(() {
        isVerified = true;
      });
    });

  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller to avoid memory leaks
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
                    "Did you know that by using SMARTIE, you're joining the 49% of Canadians who seek financial advice to enhance their financial well-being?",
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 36.0, right: 36.0),
                  child: Text(
                    "Ready to take control? Let's do this!",
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
                        "Continue",
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
