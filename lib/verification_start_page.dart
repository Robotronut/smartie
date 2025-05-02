import 'package:flutter/material.dart';
import 'package:smartie/id_scanner_front.dart';
import 'package:smartie/verification_submitted_page.dart';
import 'package:url_launcher/url_launcher.dart';

class VerificationStartPage extends StatefulWidget {
  const VerificationStartPage({super.key});
  @override
  State<VerificationStartPage> createState() => _VerificationStartPageState();
}

class _VerificationStartPageState extends State<VerificationStartPage> {
  String _selectedVerificationId = "Driver's License";
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
                top: deviceHeight(context) * 0.05,
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
                      "Let's get you verified",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0,
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(8.0)),

                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 1.0, // Same width as the first text
                    child: Text(
                      "To keep your information safe and secure, we need to quickly verify your identity. It's just a simple step to protect your account and make sure it's really you.",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 132, 132, 132),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 0.0,
                bottom: deviceHeight(context) * 0.01,
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 4.0,
                    ),
                    child: Column(
                      spacing: 20.0,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "You will need:",
                            style: TextStyle(
                              color: const Color.fromRGBO(0, 162, 233, 1),
                              fontSize: 14.0,

                              fontWeight: FontWeight.bold,
                            ),
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
                                "A valid government-issued ID (Driver's license or passport)",
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

                  //Dropdown Choice for Identity
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      value: _selectedVerificationId,
                      items:
                          ["Driver's License", "Passport", "ID Card"]
                              .map(
                                (commType) => DropdownMenuItem(
                                  value: commType,
                                  child: Text(commType),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedVerificationId = value!;
                        });
                      },
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(deviceHeight(context) * 0.01)),

                  //Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => IDScannerScreen(
                                  verifyIdType: _selectedVerificationId,
                                ),
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

                  Padding(padding: EdgeInsets.all(8.0)),

                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 1.0, // Same width as the first text
                    child: Text(
                      "Dont have a government ID? You may be able to use a residency permit, refugee document, or work/study visa.",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 132, 132, 132),
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(4.0)),

                  GestureDetector(
                    onTap: () {
                      // open web page
                      launch('https://benefitswayfinder.org/', isNewTab: true);
                    },
                    child: Text(
                      'Click here to learn more',
                      style: TextStyle(
                        color: Colors.cyan, // Color for the sign-up link
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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

  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }
}
