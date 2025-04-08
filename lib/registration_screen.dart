import 'dart:collection';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:smartie/verification_start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// ignore: must_be_immutable
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  final TextEditingController _creditorController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  bool isPhoneValidated = false;
  bool isNameValidated = false;
  bool isEmailValidated = false;
  bool isPostalValidated = false;
  String? _selectedReason;
  String? _selectedCreditor;
  String? _hasCreditor = "No";
  String selectedCategory = "";
  bool _isChecked = false;
  bool _creditorInvite = false;
  String _selectedCommunicationMode = 'Email';
  bool _showOtherCreditorInput = false;
  bool _isOtherCreditorValidated = false;

  List<DropdownMenuEntry<String>> entries() {
    var entries = <DropdownMenuEntry<String>>[];
    entries.add(const DropdownMenuEntry(value: "RBC", label: "RBC"));
    entries.add(const DropdownMenuEntry(value: "TD", label: "TD"));
       entries.add(const DropdownMenuEntry(value: "CIBC", label: "CIBC"));
    entries.add(
      const DropdownMenuEntry(value: "Scotiabank", label: "Scotiabank"),
    );
    entries.add(const DropdownMenuEntry(value: "BMO", label: "BMO"));
    entries.add(const DropdownMenuEntry(value: "HSBC", label: "HSBC"));
    entries.add(const DropdownMenuEntry(value: "ATB Financial", label: "ATB Financial"));
    entries.add(
      const DropdownMenuEntry(value: "Laurentian", label: "Laurentian"),
    );
    entries.add(
      const DropdownMenuEntry(
        value: "National Bank of Canada",
        label: "National Bank of Canada",
      ),
    );
    entries.add(const DropdownMenuEntry(value: "Other", label: "Other"));
    return entries;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey;
      }
      if (_isChecked) {
        return Color.fromRGBO(0, 162, 233, 1);
      }
      return Colors.white;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to SMARTI&E'),
        backgroundColor: Color(0xFF008FD7), // Same color as the login button
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
                  'Ready to make your financial journey smoother than ever?',
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
                  'Let\'s get you set up in 3 simple steps. What can we call you?',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                // Full Name Input
                TextFormField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    isNameValidated = true;
                    return null;
                  },
                ),
                SizedBox(height: 10),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'How can we reach you?',
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                ),
                
                SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedCommunicationMode,
                  items:
                      ["Email", "Mobile Phone"]
                          .map(
                            (commType) => DropdownMenuItem(
                              value: commType,
                              child: Text(commType),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                      setState(() {
                        _selectedCommunicationMode = value!;
                      });
                  },
                ),

                SizedBox(height: 10),

                Column(
                  children: [
                    _selectedCommunicationMode == 'Email' ? 
                    // Email Input
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Your Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        isEmailValidated = true;
                        return null;
                      },
                    )

                    :

                    // Mobile Number Input
                    IntlPhoneField(
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text(
                          "Enter phone number",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      ),
                      initialCountryCode: 'CA',
                      showCountryFlag: false,
                      onChanged: (phone) {
                        print("phone pressed $phone");
                        isPhoneValidated = true;
                      },
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Text(
                        "Did a creditor or another business send you to SMARTI&E today?",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 132, 132, 132),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: _hasCreditor,
                        items:
                            ["No", "Yes"]
                                .map(
                                  (reason) => DropdownMenuItem(
                                    value: reason,
                                    child: Text(reason),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          _hasCreditor = value;
                          if (value == "Yes") {
                            setState(() {
                              _creditorInvite = true;
                            });
                          } else {
                            setState(() {
                              _creditorInvite = false;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please add their name or select from below:",
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 132, 132, 132),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                IgnorePointer(
                  ignoring: _creditorInvite ? false : true,
                  child: DropdownMenu<String>(
                    controller: iconController,
                    enableFilter: true,
                    width: screenWidth,
                    requestFocusOnTap: true,
                    leadingIcon: const Icon(Icons.search),
                    label: const Text('Creditor / Business Name'),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      fillColor:
                          _creditorInvite ? Colors.transparent : Color.fromRGBO(128, 128, 128, 0.5),
                      border: OutlineInputBorder(),
                    ),
                    dropdownMenuEntries: entries(),
                    onSelected: (value) {
                      if (value == 'Other') {
                        setState(() {
                          _showOtherCreditorInput = true;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),

                //Other Creditor Conditional Text Input
                Visibility(
                  visible: _showOtherCreditorInput,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Other Creditor',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter creditor/business name';
                      }
                      _isOtherCreditorValidated = true;
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 10),

                // Reason for Registration Dropdown
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: _selectedReason,
                  decoration: InputDecoration(
                    labelText: 'How can Smarti&e help you today?',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      [
                            "Help Budgeting",
                            "Build a Repayment Plan",
                            "Apply for Low-Income Support",
                            "Apply for Credit",
                            "Get Help with Renting",
                            "Plan for a Major Life Change",
                            "Start University or Leave Home with Confidence",
                            "Increase Your Income / Understand Your Benefits",
                            "Newcomer to Canada",
                            "Prepare for Credit Counseling",
                            "Prepare for Insolvency",
                          ]
                          .map(
                            (reason) => DropdownMenuItem(
                              value: reason,
                              child: Text(reason),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    _selectedReason = value;
                  },
                ),
                SizedBox(height: 10),

                Padding(padding: EdgeInsets.all(8.0)),

                //Truth Verification Agreement Checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.0,
                  children: [
                    // Checkbox
                    SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: Transform.scale(
                        scale: 0.8,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          side: WidgetStateBorderSide.resolveWith(
                            (states) => BorderSide(
                              width: 1.0,
                              color: const Color.fromARGB(255, 132, 132, 132),
                            ),
                          ),
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith(getColor),
                          value: _isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _isChecked = newValue!;
                            });
                          },
                        ),
                      ),
                    ),

                    // Verification Agreement Text
                    Expanded(
                      child: Text(
                        "I agree that I provided accurate and valid identification documents, including a government-issued ID and a selfie.",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 132, 132, 132),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.all(8.0)),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &
                          _isChecked & (isEmailValidated | isPhoneValidated)) {
                        // Handle form submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registration Successful!'),
                            duration: Durations.extralong1,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationStartPage(),
                          ),
                        );
                      } else if (!isNameValidated) {
                        // Show a warning if phone is not validated
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Missing Full Name'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        _nameFocusNode.requestFocus();
                      } else if (_selectedCommunicationMode == "Email" && !isEmailValidated) {
                        // Show a warning if phone is not validated
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Missing Email.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        _emailFocusNode.requestFocus();
                      } else if (_selectedCommunicationMode == "Mobile Phone" && !isPhoneValidated) {
                        // Show a warning if phone is not validated
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You must enter a valid phone number before proceeding.',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        _phoneFocusNode.requestFocus();
                      } else if (!_isChecked) {
                        // Show a warning if checkbox is not checked
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You must agree to the terms before proceeding.',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 162, 233, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      "Let's go",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
