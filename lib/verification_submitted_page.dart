import 'package:flutter/material.dart';
import 'package:smartie/bank_terms_cond_screen.dart';
// Import the second screen

class VerificationSubmittedPage extends StatelessWidget {
  const VerificationSubmittedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  Padding(padding: EdgeInsets.all(48.0)),

                  Container(
                    height: MediaQuery.of(context).size.width * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(0, 162, 233, 1),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(180.0)
                    ),
                    child: Icon(
                        Icons.check,
                        color: const Color.fromRGBO(0, 162, 233, 1),
                        size: MediaQuery.of(context).size.width * 0.1,
                        opticalSize: 2.0,
                        weight: 2.0,
                      ),
                  ),

                  Padding(padding: EdgeInsets.all(4.0)),

                  Text(
                    textAlign: TextAlign.center,
                    "Thank you!",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(8.0)),

                  Text(
                    "Your verification data has been successfully submitted",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),

                  Padding(padding: EdgeInsets.all(64.0)),

                  //Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BankTermsCondScreen()
                          ),
                          (Route<dynamic> route) =>
                              false, // Remove all existing routes
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
            ),
          ],
        ),
      ),
    );
  }
}
