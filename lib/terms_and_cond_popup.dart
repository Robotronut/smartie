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
                        "SMARTIE - Terms and Conditions for Bank Account Connection",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24.0,
                        ),
                      ),
                    
                    Text(
                        "Last Updated: April 4, 2025",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                    Text(
                      "1. Introduction",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    Text(
                        "By using SMARTIE and connecting your bank account, you agree to these Terms and Conditions. Please read them carefully. This process allows SMARTIE to access your financial data solely for providing personalized financial insights, affordability assessments, and tailored advice. No credit check will be conducted.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                    Text(
                        "2. Consent to Access Financial Data",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "You consent to allow SMARTIE to securely access your financial data from your connected bank account(s) to provide tailored insights and recommendations. This access is read-only and used solely for the purposes described in this agreement.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                    Text(
                        "3. Data Usage and Privacy",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "• SMARTIE will never store or share your banking credentials.\n• Your financial data will be accessed securely and used only to provide you with personalized insights, budgeting tools, and recommendations.\n• Your information will not be sold or shared with third parties without your explicit consent, unless required by law.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                    Text(
                        "4. No Impact on Credit Score",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "Connecting your bank account with SMARTIE does not involve a credit check and will not affect your credit score in any way.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                      Text(
                        "5. Security and Encryption",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "SMARTIE uses industry-standard encryption protocols to ensure that your data is transmitted and stored securely. We are committed to maintaining the highest standards of data protection.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                      Text(
                        "6. User Responsibilities",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "You agree to provide accurate information and ensure that you have the authority to connect the bank accounts you choose to link with SMARTIE.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                      Text(
                        "7. Termination",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "You may disconnect your bank account from SMARTIE at any time. Upon disconnection, SMARTIE will immediately cease access to your financial data.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                      Text(
                        "8. Changes to Terms",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "SMARTIE reserves the right to modify these Terms and Conditions. Any changes will be communicated to you via the app, and your continued use of SMARTIE following such changes will constitute acceptance.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),

                      Text(
                        "9. Contact Information",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    Text(
                        "For any questions or concerns regarding these Terms and Conditions, please contact us.",
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
