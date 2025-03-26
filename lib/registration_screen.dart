import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:smartie/verification_start_page.dart';
import 'package:smartie/user_assessment.dart';
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
  // final TextEditingController _ageController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _questionsController = TextEditingController();

  bool isPhoneValidated = false;
  String? _selectedSex;
  String? _selectedAge;
  String? _selectedEmploymentStatus;
  String? _selectedReason;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
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
        title: Text('Registration'),
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
                  'Enter your basic details',
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
                  'Give us just a bit to do our magic and we\'ll get you on your way.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                // Full Name Input
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                // Email Input
                TextFormField(
                  controller: _emailController,
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
                    return null;
                  },
                ),
                SizedBox(height: 10),
                // Mobile Number Input
                IntlPhoneField(
                  controller: _phoneController,
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
                  onChanged: (phone) {},
                  validator: (value) {
                    isPhoneValidated = false;
                    print(value);
                    if (value!.isValidNumber()) {
                      setState(() {
                          isPhoneValidated = true;
                      });
                    } else {
                      setState(() {
                          isPhoneValidated = false;
                      });
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                // Age and Sex Inputs
                Row(
                  children: [
                    // Age Input

                    // Sex Dropdown
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: _selectedAge,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(),
                        ),
                        items:
                            ['18-25', '25-35', '35-45', '45-55', '55-65', '65+']
                                .map(
                                  (age) => DropdownMenuItem(
                                    value: age,
                                    child: Text(age),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          _selectedAge = value;
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    // Sex Dropdown
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: _selectedSex,
                        decoration: InputDecoration(
                          labelText: 'Sex',
                          border: OutlineInputBorder(),
                        ),
                        items:
                            ['Male', 'Female', 'Other', 'Not Say']
                                .map(
                                  (sex) => DropdownMenuItem(
                                    value: sex,
                                    child: Text(sex),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          _selectedSex = value;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                // Postal Code Input
                TextFormField(
                  controller: _postalCodeController,
                  decoration: InputDecoration(
                    labelText: 'Postal Code/Zip',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your postal code';
                    }
                    String TrimValue = value.trim();
                    TrimValue.replaceAll(' ', '');

                    print(TrimValue);
                    print(TrimValue.length);
                    print(
                      RegExp(
                        r'^[A-Za-z]\d[A-Za-z]\d[A-Za-z]\d$',
                      ).hasMatch(TrimValue),
                    );
                    if (!RegExp(
                      r'^[A-Za-z]\d[A-Za-z]\d[A-Za-z]\d$',
                    ).hasMatch(TrimValue)) {
                      return "Invalid Postal Code";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                // Employment Status Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedEmploymentStatus,
                  decoration: InputDecoration(
                    labelText: 'Employment Status',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      ['Employed', 'Unemployed', 'Student', 'Retired', 'Other']
                          .map(
                            (status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    _selectedEmploymentStatus = value;
                  },
                ),
                SizedBox(height: 10),
                // Reason for Registration Dropdown
                TextFormField(
                  controller: _questionsController,
                  decoration: InputDecoration(
                    labelText: 'Ask me a question',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                // Reason for Registration Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedReason,
                  decoration: InputDecoration(
                    labelText: 'Reason for Registration',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      ['Personal Use', 'Business Use', 'Other']
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
                          fontFamily: 'GalanoGrotesqueMedium',
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
                      if (_formKey.currentState!.validate() & _isChecked & isPhoneValidated) {
                        // Handle form submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Successful!')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserAssessment(),
                          ),
                        );
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
                      } else if (!isPhoneValidated) {
                        // Show a warning if phone is not validated
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You must enter a valid phone number before proceeding.',
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
