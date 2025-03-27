import 'package:flutter/material.dart';
import 'package:smartie/id_scanner_front.dart';
import 'package:smartie/id_scannner_back.dart';
import 'package:smartie/id_scanner_selfie.dart';
import 'package:smartie/home_screen.dart';

class VerificationSelfiePage extends StatelessWidget {
  const VerificationSelfiePage({super.key});

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
                top: 24.0,
                bottom: 4.0,
                left: 18.0,
                right: 18.0,
              ),
              child: Column(
                children: [
                  // Company Icon
                  Image.asset(
                    'assets/images/smartie_logo.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),

                  Padding(padding: EdgeInsets.all(4.0)),

                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 1.0, // Adjust width to 80% of the screen
                    child: Text(
                      textAlign: TextAlign.center,
                      "Id and You Photo",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(8.0)),

                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 1.0, // Same width as the first text
                    child: Text(
                      "You're close!",
                      style: TextStyle(
                        color: const Color.fromRGBO(0, 162, 233, 1),
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 1.0, // Same width as the first text
                    child: Text(
                      "Now we just need one more selfie ID photo.",
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
                top: 10.0,
                bottom: 6.0,
                left: 6.0,
                right: 6.0,
              ),

              child: Column(
                children: [
                  Image.asset(
                    'assets/images/selfie_placeholder.jpg',
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 6.0,
                      bottom: 6.0,
                      left: 6.0,
                      right: 6.0,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        spacing: 20.0,
                        children: [
                          Center(
                            child: Text(
                              "Final verification step",
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
                                  "Using the example image above, position your Id beside your face to verify your identity.",
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    //Submit Button
                    child: SizedBox(
                      width: double.infinity,

                      child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IdScannerSelfie(),
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
                          "Start Now",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
