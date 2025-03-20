import 'package:flutter/material.dart';

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

                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: const Color.fromRGBO(0, 162, 233, 1),
                    size: MediaQuery.of(context).size.width * 0.35,
                  ),

                  Padding(padding: EdgeInsets.all(4.0)),

                  Text(
                    textAlign: TextAlign.center,
                    "Thank you!",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                      fontFamily: 'GalanoGrotesqueMedium',
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(8.0)),

                  Text(
                    "Your verification data has been successfully submitted",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'GalanoGrotesqueMedium',
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Padding(padding: EdgeInsets.all(64.0)),

                  //Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
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
