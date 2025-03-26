import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // Add other scopes as needed
    ],
  );

  bool _isLoggedIn = false;
  String _message = '';

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled login

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (accessToken != null && idToken != null) {
        final response = await http.post(
          Uri.parse('https://mic.thegwd.ca/test/api/gglogin'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'accessToken': accessToken,
            'idToken': idToken,
          }),
        );

        if (response.statusCode == 200) {
          setState(() {
            _isLoggedIn = true;
            _message =
                'Login successful: ${jsonDecode(response.body)['message']}';
          });
        } else {
          setState(() {
            _message =
                'Login failed: ${response.statusCode} - ${response.body}';
          });
        }
      } else {
        setState(() {
          _message = 'Failed to retrieve access or ID token.';
        });
      }
    } catch (error) {
      setState(() {
        _message = 'Error during login: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!_isLoggedIn)
              ElevatedButton(
                onPressed: _handleSignIn,
                child: Text('Sign in with Google'),
              ),
            if (_isLoggedIn) Text(_message, style: TextStyle(fontSize: 18)),
            if (_message.isNotEmpty && !_isLoggedIn)
              Text(_message, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
