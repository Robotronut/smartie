import 'package:flutter/material.dart';
import 'package:smartie/id_scanner_front.dart';
import 'package:smartie/id_scannner_back.dart';
import 'package:smartie/home_screen.dart';
import 'package:smartie/verification_selfie_page.dart';

class VerificationIdBackPage extends StatelessWidget {
  const VerificationIdBackPage({super.key, required this.idType});
  final String idType;
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

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
                top: deviceHeight(context) * 0.08,
                bottom: deviceHeight(context) * 0.03,
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

                  Padding(
                    padding: EdgeInsets.all(deviceHeight(context) * 0.025),
                  ),

                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 1.0, // Adjust width to 80% of the screen
                    child: Text(
                      textAlign: TextAlign.center,
                      "Second Side Id Photo",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(deviceHeight(context) * 0.01),
                  ),

                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 1.0, // Same width as the first text
                    child: Text(
                      "Not so hard eh! Let's get a photo of the back of the ID now.",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 132, 132, 132),
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 0.0,
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 20.0,
                      children: [
                        Center(
                          child: Text(
                            "Well that looks successful, next step",
                            style: TextStyle(
                              color: const Color.fromRGBO(0, 162, 233, 1),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_box_outlined,
                              color: const Color.fromRGBO(0, 162, 233, 1),
                            ),
                            Padding(padding: EdgeInsets.all(4.0)),
                            Expanded(
                              child: Text(
                                "Using the same Id, turn it over so we can capture the other side.",
                                style: TextStyle(fontSize: 14.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_box_outlined,
                              color: const Color.fromRGBO(0, 162, 233, 1),
                            ),
                            Padding(padding: EdgeInsets.all(4.0)),
                            Expanded(
                              child: Text(
                                "Make sure you are in a well-lit place",
                                style: TextStyle(fontSize: 14.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(8.0)),

                  if (idType == "Passport")
                    //Skip Button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          // skip to selfie step
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const VerificationSelfiePage(),
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(
                            128,
                            128,
                            128,
                            1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Passport Doesn't Have a Back? Skip to Selfie",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),

                  Padding(padding: EdgeInsets.all(8.0)),

                  //Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IDScannerIdBackScreen(),
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
                        "Take Picture of Back of ID",
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
