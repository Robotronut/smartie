import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'verification_start_page.dart';
import 'user_assessment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Galano', // Use your font family name here
      ),
      home: LoginScreen()
    );
  }
}
