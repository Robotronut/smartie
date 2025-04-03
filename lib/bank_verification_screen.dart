import 'package:flutter/material.dart';

class BankVerifyScreen extends StatelessWidget {
  const BankVerifyScreen({super.key});
  
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
                    "Your bank details are being verified. You’ll receive an email from us once the verification is complete.",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
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
