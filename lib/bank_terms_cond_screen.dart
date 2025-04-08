import 'package:flutter/material.dart';
import 'package:smartie/banks_selection_screen.dart';
import 'package:smartie/terms_and_cond_popup.dart';

class BankTermsCondScreen extends StatefulWidget {
  const BankTermsCondScreen({super.key});
  @override
  State<BankTermsCondScreen> createState() => _BankTermsCondScreenState();
}

class _BankTermsCondScreenState extends State<BankTermsCondScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey;
      }
      if(_isChecked){
        return Color.fromRGBO(0, 162, 233, 1);
      }
      return Colors.white;
      
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          spacing: 12.0,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 72.0,
                bottom: 24.0,
                left: 28.0,
                right: 28.0,
              ),
              child: Column(
                children: [
                  // Company Icon
                  Image.asset(
                    'assets/images/smartie_logo.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),

                  Padding(padding: EdgeInsets.all(48.0)),

                  Icon(
                    Icons.lock_outline_rounded,
                    color: const Color.fromRGBO(0, 162, 233, 1),
                    size: MediaQuery.of(context).size.width * 0.12,
                  ),

                  Padding(padding: EdgeInsets.all(12.0)),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      textAlign: TextAlign.center,
                      "One Last Step",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(6.0)),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "By connecting your bank SmartI&E is able to give you accurate personalized insights, smarter recommendations, ans a clearer view of your finances - without impacting your credit score.",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(8.0)),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => TermsAndCondPopUp())
                      );
                    }, 
                    child: Text(
                      "View Terms and Conditions",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: const Color.fromRGBO(0, 162, 233, 1),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color.fromRGBO(0, 162, 233, 1),
                        decorationThickness: 2.0,
                        fontWeight: FontWeight.bold,
                        )
                      )
                  ),

                  Padding(padding: EdgeInsets.all(12.0)),

                  //Truth Verification Agreement Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.0,
                    children: [
                      // Checkbox
                      SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                            side: WidgetStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 1.0, color: const Color.fromARGB(255, 132, 132, 132)),
                            ),
                            checkColor: Colors.white,
                            fillColor: WidgetStateProperty.resolveWith(getColor),
                            value: _isChecked, 
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isChecked = newValue!;
                              });
                            },
                          )
                        )
                      ),

                    // Verification Agreement Text
                    Expanded(
                      child:Text(
                        "I agree that I have reviewed and understood the Terms and Conditions.",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 132, 132, 132),
                          fontSize: 12.0,
                        ),
                        )
                    ),
                  ],
                ),

                Padding(padding: EdgeInsets.all(8.0)),

                //Submit Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (_isChecked) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BanksSelectionScreen())
                        );
                    } else if (!_isChecked) {
                        // Show a warning if checkbox is not checked
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('You must agree to the terms before proceeding.'), backgroundColor: Colors.red),
                        );
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: _isChecked ? const Color.fromRGBO(0, 162, 233, 1) : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
