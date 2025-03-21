import 'dart:ui';

import 'package:smartie/verification_start_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _ageController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _questionsController = TextEditingController();

  String? _selectedCountryCode = '+01'; // Default country code
  String? _selectedSex;
  String? _selectedAge;
  String? _selectedEmploymentStatus;
  String? _selectedReason;
  bool _isChecked = false;

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    // Country Code Dropdown
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: _selectedCountryCode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items:
                            ['+01', '+91', '+44', '+61', '+81']
                                .map(
                                  (code) => DropdownMenuItem(
                                    value: code,
                                    child: Text(code),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          _selectedCountryCode = value;
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    // Phone Number Input
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
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
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    Expanded(
                      // Use Expanded to allow the text to wrap
                      child: Text(
                        'I agree to the terms and conditions and privacy policy.',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ), // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Successful!')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VerificationStartPage(),
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
  }

  void setState(Null Function() param0) {}
}
