import 'package:smartie/verification_start_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class UserAssessment extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String? _repaymentPlan = "With creditors (including utility)";
  String? _housingPlan = "Private rental";
  String? _budgetPlan = "Savings / Retirement / Investment";
  bool _tariffChecked = false;
  bool _creditChecked = false;
  bool _newChecked = false;
  bool _divorceChecked = false;
  bool _disputeChecked = false;
  bool _gamblingChecked = false;

  UserAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Assessment'),
            backgroundColor: Color(
              0xFF008FD7,
            ), // Same color as the login button
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'Enter your preferences',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // Subtitle
                    Text(
                      'Now, we\'ll just collect a bit more info about what you are looking for in your SMARTI&E experience.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _repaymentPlan,
                            decoration: InputDecoration(
                              labelText: 'Repayment Plan',
                              border: OutlineInputBorder(),
                            ),
                            items:
                                [
                                      'With creditors (including utility)',
                                      'With friends and family',
                                      'To pay fines (provincial)',
                                    ]
                                    .map(
                                      (plan) => DropdownMenuItem(
                                        value: plan,
                                        child: Text(plan),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              _repaymentPlan = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _tariffChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _tariffChecked = value!;
                            });
                          },
                        ),
                        Expanded(
                          // Use Expanded to allow the text to wrap
                          child: Text(
                            'Apply for low income tariffs or hardship plans.',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _creditChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _creditChecked = value!;
                            });
                          },
                        ),
                        Expanded(
                          // Use Expanded to allow the text to wrap
                          child: Text(
                            'Preparation for credit counselling appointment.',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _newChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _newChecked = value!;
                            });
                          },
                        ),
                        Expanded(
                          // Use Expanded to allow the text to wrap
                          child: Text(
                            'New to Canada / thin credit file.',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _housingPlan,
                            decoration: InputDecoration(
                              labelText: 'Housing',
                              border: OutlineInputBorder(),
                            ),
                            items:
                                ['Private rental', 'Social rental']
                                    .map(
                                      (plan) => DropdownMenuItem(
                                        value: plan,
                                        child: Text(plan),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              _housingPlan = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _budgetPlan,
                            decoration: InputDecoration(
                              labelText: 'Budget & Financing',
                              border: OutlineInputBorder(),
                            ),
                            items:
                                [
                                      'Savings / Retirement / Investment',
                                      'Event / Wedding',
                                      'Starting University',
                                      'Long term sick',
                                      'Maternity leave',
                                    ]
                                    .map(
                                      (plan) => DropdownMenuItem(
                                        value: plan,
                                        child: Text(plan),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              _budgetPlan = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // open web page
                        launch(
                          'https://benefitswayfinder.org/',
                          isNewTab: true,
                        );
                      },
                      child: Text(
                        'Understand your benefits.\nVisit: https://benefitswayfinder.org',
                        style: TextStyle(
                          color: Colors.cyan, // Color for the sign-up link
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 8.0)),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _divorceChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _divorceChecked = value!;
                            });
                          },
                        ),
                        Expanded(
                          // Use Expanded to allow the text to wrap
                          child: Text(
                            'Divorce or prenuptial preparation.',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _disputeChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _disputeChecked = value!;
                            });
                          },
                        ),
                        Expanded(
                          // Use Expanded to allow the text to wrap
                          child: Text(
                            'Dispute resolution.',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _gamblingChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _gamblingChecked = value!;
                            });
                          },
                        ),
                        Expanded(
                          // Use Expanded to allow the text to wrap
                          child: Text(
                            'Gambling management.',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    // Submit Button
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle form submission
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Assessment Complete!')),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const VerificationStartPage(),
                              ), // Replace with your registration page widget
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF008FD7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 30,
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void setState(Null Function() param0) {}

  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }
}
