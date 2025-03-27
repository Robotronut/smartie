import 'package:flutter/material.dart';
import 'package:smartie/id_scanner_front.dart';

class VerificationStartPage extends StatelessWidget {
  const VerificationStartPage({super.key});

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
                top: 64.0,
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

                  Padding(padding: EdgeInsets.all(24.0)),

                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 1.0, // Adjust width to 80% of the screen
                    child: Text(
                      textAlign: TextAlign.center,
                      "Let's get you verified",
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
                      "Give us just a bit to do our magic and we'll get you on your way.",
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 236, 235, 235),
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 20.0,
                        children: [
                          Center(
                            child: Text(
                              "Before you start, please:",
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
                                  "Prepare a valid government-issued ID",
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
                                  "Be prepared to take a take another photo of the otherside of your ID",
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

                  Padding(padding: EdgeInsets.all(8.0)),

                  //Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IDScannerScreen(),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
