import 'package:flutter/material.dart';
import 'package:smartie/banks_selection_screen.dart';

class BankLoginScreen extends StatefulWidget {
  final String imagePath;
  const BankLoginScreen({super.key, required this.imagePath});

  @override
  // ignore: library_private_types_in_public_api
  _BankLoginScreenState createState() => _BankLoginScreenState();
}

class _BankLoginScreenState extends State<BankLoginScreen> {
  
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
                Text(
                  'Bank Sign In Page Coming Soon',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                  ),
                ),

                Padding(padding: const EdgeInsets.all(8.0)),

                SizedBox(
                  width: double.infinity, 
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => BanksSelectionScreen())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 162, 233, 1),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Return to previous page',
                      style: TextStyle(
                        color: Colors.white,
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
