import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartie/home_screen.dart';
import 'dart:convert';

import 'package:smartie/login_screen.dart'; // For JSON decoding
import 'package:smartie/registration_screen.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotpasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Function to validate credentials
  Future<void> _sendForgotPassword() async {
    try {
      print("Before currentState check: ${_formKey.currentState}"); // Debugging
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        // Use the correct API URL
        const String apiUrl = "https://mic.thegwd.ca/test/api/resetpassword";
        print(_emailController.text);
        try {
          final response = await http.post(
            Uri.parse(apiUrl),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"email": _emailController.text}),
          );
          print(response.body);
          // Log the response status code and body for debugging
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            // Check for the success message in the response
            print(data['message']);
            if (data['message'] == "Successful!") {
              // Navigate to the next screen if login is successful
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else {
              _showErrorSnackbar("Check your Email");
            }
          } else {
            _showErrorSnackbar("An error occurred. Please try again.");
          }
        } catch (e) {
          _showErrorSnackbar("Failed to connect to the server.");
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {}
    } catch (e) {
      print("Error: $e");
    }
  }

  // Function to show error messages
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 3, 24, 56),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align items at the start
              children: [
                // Logo at the top
                Image.asset(
                  'assets/images/smartie_logo_white.png',
                  height: 55,
                ), // Replace with your logo path
                SizedBox(height: 15),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Let\'s get you back in.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                // Light blue box with rounded corners
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Form(
                    // <--- Add the Form Widget here.
                    key: _formKey, // <--- Assign the key here.
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 15),
                        _isLoading
                            ? CircularProgressIndicator()
                            : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _sendForgotPassword,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF008FD7),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // Sign up text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to the forgot password page
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ), // Replace with your registration page widget
                        );
                      },
                      child: Text(
                        'Return to Login',
                        style: TextStyle(
                          color: Colors.cyan, // Color for the sign-up link
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Sign up text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
                      style: TextStyle(
                        color: Colors.white,
                      ), // Text color for contrast
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the registration page
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationPage(),
                          ), // Replace with your registration page widget
                        );
                      },
                      child: Text(
                        'Sign up.',
                        style: TextStyle(
                          color: Colors.cyan, // Color for the sign-up link
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Google Sign-Up Button
                SizedBox(
                  width: double.infinity, // Match the width of the input fields
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add your Google sign-up logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.white, // White background for Google button
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: Image.asset(
                      'assets/images/google_logo.png', // Replace with your Google logo asset
                      height: 20,
                    ),
                    label: Text(
                      'Sign up with Google',
                      style: TextStyle(
                        color: Colors.black,
                      ), // Black text for contrast
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Microsoft Sign-Up Button
                SizedBox(
                  width: double.infinity, // Match the width of the input fields
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add your Microsoft sign-up logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        0xFF2F2F2F,
                      ), // Dark background for Microsoft button
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: Image.asset(
                      'assets/images/microsoft_logo.png', // Replace with your Microsoft logo asset
                      height: 20,
                    ),
                    label: Text(
                      'Sign up with Microsoft',
                      style: TextStyle(
                        color: Colors.white,
                      ), // White text for contrast
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),

                  child: Text(
                    '© 2025 SMARTI&E',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
