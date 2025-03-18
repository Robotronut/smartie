import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _questionsController = TextEditingController();

  String? _selectedCountryCode = '+01'; // Default country code
  String? _selectedSex;
  String? _selectedEmploymentStatus;
  String? _selectedReason;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Enter your basic details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                // Subtitle
                Text(
                  'Give us just a bit to do our magic and we\'ll get you on your way.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                // Full Name Input
                TextFormField(
                  controller: _nameController,
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
                SizedBox(height: 20),
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
                SizedBox(height: 20),
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
                    SizedBox(width: 10),
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
                SizedBox(height: 20),
                // Age and Sex Inputs
                Row(
                  children: [
                    // Age Input
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Enter a valid age';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    // Sex Dropdown
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<String>(
                        value: _selectedSex,
                        decoration: InputDecoration(
                          labelText: 'Sex',
                          border: OutlineInputBorder(),
                        ),
                        items:
                            ['Male', 'Female', 'Other', 'Rather not say']
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
                SizedBox(height: 20),
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
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Enter a valid postal code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Successful!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF008FD7),
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
}
