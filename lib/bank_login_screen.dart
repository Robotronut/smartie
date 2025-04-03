import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartie/bank_verification_screen.dart';
// import 'package:smartie/banks_selection_screen.dart';
import 'package:smartie/forgotpassword_screen.dart';
import 'package:smartie/home_screen.dart';
// import 'package:smartie/summary_screen.dart';

class BankLoginScreen extends StatefulWidget {
  final String imagePath;
  const BankLoginScreen({super.key, required this.imagePath});

  @override
  // ignore: library_private_types_in_public_api
  _BankLoginScreenState createState() => _BankLoginScreenState();
}

class _BankLoginScreenState extends State<BankLoginScreen> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Function to validate credentials
  Future<void> _validateAndLogin() async {
    try {
      print("Before currentState check: ${_formKey.currentState}"); // Debugging
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BankVerifyScreen()),
        );
        return;
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Align items at the start
              children: [
                // Logo at the top
                Image.asset(
                  widget.imagePath,
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.3,
                ), // Replace with your logo path
                SizedBox(height: 15),
                // Text(
                //   'Bank Sign In Page Coming Soon',
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.blueGrey,
                //   ),
                // ),

                // Padding(padding: const EdgeInsets.all(8.0)),

                // SizedBox(
                //   width: double.infinity, 
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.pop(
                //         context,
                //         MaterialPageRoute(builder: (context) => BanksSelectionScreen())
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color.fromRGBO(0, 162, 233, 1),
                //       padding: EdgeInsets.symmetric(vertical: 15),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //     ),
                //     child: Text(
                //       'Return to previous page',
                //       style: TextStyle(
                //         color: Colors.white,
                //       ), // White text for contrast
                //     ),
                //   ),
                // ),

                // Padding(padding: const EdgeInsets.all(8.0)),

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
                            labelText: 'Card Number',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your card number';
                            }
                            if (!RegExp(r'^\d{12}$').hasMatch(value)) {
                              return 'Enter a valid card number';
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
                                  backgroundColor: const Color.fromRGBO(
                                    0,
                                    162,
                                    233,
                                    1,
                                  ),
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

                // SizedBox(
                //   width: double.infinity, 
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.pop(
                //         context,
                //         MaterialPageRoute(builder: (context) => SummaryScreen())
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color.fromRGBO(0, 162, 233, 1),
                //       padding: EdgeInsets.symmetric(vertical: 15),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //     ),
                //     child: Text(
                //       'Go to Summary',
                //       style: TextStyle(
                //         color: Colors.white,
                //       ), // White text for contrast
                //     ),
                //   ),
                // ),
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
