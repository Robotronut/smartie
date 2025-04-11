import 'package:flutter/material.dart';
import 'package:smartie/bank_terms_cond_screen.dart';
import 'package:smartie/verification_start_page.dart';
// Import the second screen

class VerificationSubmittedPage extends StatelessWidget {
  const VerificationSubmittedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            spacing: 12.0,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 56.0,
                  bottom: 24.0,
                  left: 28.0,
                  right: 28.0,
                ),
                child: Column(
                  children: [
                    // Company Icon
                    Image.asset(
                      'assets/images/smartie_logo.png',
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),

                    Padding(padding: EdgeInsets.all(64.0)),

                    Text(
                      textAlign: TextAlign.center,
                      "Page coming soon...",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
