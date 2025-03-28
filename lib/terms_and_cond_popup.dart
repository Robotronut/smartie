import 'package:flutter/material.dart';

class TermsAndCondPopUp extends StatelessWidget {
  const TermsAndCondPopUp({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
                padding: EdgeInsets.only(
                  top: 72.0,
                  bottom: 24.0,
                  left: 28.0,
                  right: 28.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 12.0,
                  children: [
                    Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24.0,
                        ),
                      ),
                    
                    Text(
                        "Last Updated: March 25, 2025",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                    Text(
                        "Welcome to SMARTI&E. By using our mobile application, you agree to comply with and be bound by the following terms and conditions. Please read them carefully before proceeding.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                    Text(
                        "1. Acceptance of Terms",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "By accessing or using SMARTI&E, you confirm that you have read, understood, and agreed to these Terms and Conditions. If you do not agree, please do not use the app.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                    Text(
                        "2. Eligibility",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "To use SMARTI&E, you must:\n\n- Be at least 18 years old or the legal age of financial responsibility in your country.\n- Provide accurate and complete information when creating an account.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                    Text(
                        "3. Financial Services Disclaimer",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "SMARTI&E does not provide financial, investment, tax, or legal advice. Any financial analysis, predictions, or recommendations offered by the app are for informational purposes only. You are responsible for conducting your own research and consulting a professional before making financial decisions.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                      Text(
                        "4. Privacy Policy",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "We value your privacy. Our Privacy Policy explains how we collect, store, and protect your data. By using the app, you agree to our data practices as outlined in the Privacy Policy.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                    FilledButton(
                      onPressed: () => {
                        Navigator.pop(context)
                      }, 
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 162, 233, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "I have read the terms and conditions",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ]
                ),
              ),
        ),
    );
  }
}
