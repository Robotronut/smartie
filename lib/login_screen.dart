import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:smartie/forgotpassword_screen.dart';
import 'package:smartie/google_login_screen.dart';
import 'package:smartie/registration_screen.dart';
import 'package:smartie/user_assessment.dart';

import 'dart:convert'; // For JSON decoding
import 'home_screen.dart'; // Import the second screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Function to validate credentials
  Future<void> _validateAndLogin() async {
    try {
      print("Before currentState check: ${_formKey.currentState}"); // Debugging
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        // Use the correct API URL
        const String apiUrl = "https://mic.thegwd.ca/test/api/login";

        try {
          final response = await http.post(
            Uri.parse(apiUrl),
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              "email": _emailController.text,
              "password": _passwordController.text,
            }),
          );
          print(response.body);
          // Log the response status code and body for debugging
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            // Check for the success message in the response
            if (data['message'] == "Login successful!") {
              // Navigate to the next screen if login is successful
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else {
              _showErrorSnackbar(data['message']);
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
      } else {
        print("Login has failed: ${_formKey.currentState}"); // Debugging
      }
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
                  'Sign In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Welcome back! Let\'s get started',
                  style: TextStyle(fontSize: 16, color: Colors.white),
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
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
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
                                onPressed: _validateAndLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF008FD7),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ForgotpasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color:
                                      Colors.grey, // Color for the sign-up link
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
                    Text(
                      'Not a member? ',
                      style: TextStyle(
                        color: Colors.white,
                      ), // Text color for contrast
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the registration page
                        Navigator.push(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoogleLoginScreen(),
                        ),
                      );

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
                      'Login with Google',
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
                        0xFFFFFFFF,
                      ), // Dark background for Microsoft button
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: Image.asset(
                      'assets/images/apple_logo_transparent.png', // Replace with your Microsoft logo asset
                      height: 20,
                    ),
                    label: Text(
                      'Login with Apple',
                      style: TextStyle(
                        color: Colors.black,
                      ), // White text for contrast
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  '© 2025 SMARTI&E',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
