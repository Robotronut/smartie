import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smartie/summary_screen.dart';

class SetPwdScreen extends StatefulWidget {
  const SetPwdScreen({super.key});

  @override
  _SetPwdScreenState createState() => _SetPwdScreenState();
}

class _SetPwdScreenState extends State<SetPwdScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _pwdVisible = false;
  bool _confirmPwdVisible = false;
  bool _validPin = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:10.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/smartie_logo.png',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),

                Padding(padding: EdgeInsets.all(20.0)),

                !_validPin ?

                Column(
                  children: [
                    Text(
                    "Verify Your Email/Phone Number",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(0, 162, 233, 1),
                      ),
                    textAlign: TextAlign.center,
                  ),

                  Padding(padding: EdgeInsets.all(8.0)),
                  
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Text(
                      "We've sent a 6-digit code to the phone number or email you registered with.",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blueGrey
                        ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(8.0)),

                  Pinput(
                    length: 6,
                    onCompleted: (pin){
                      setState(() {
                        _validPin = true;
                      });
                    },
                    defaultPinTheme: PinTheme(
                      width: 42,
                      height: 48,
                      textStyle: TextStyle(fontSize: 20, color: Colors.black),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: TextStyle(fontSize: 20, color: const Color.fromRGBO(0, 162, 233, 1)),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromRGBO(0, 162, 233, 1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(12.0)),

                  Text(
                    "Didn't recieve code?",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: const Color.fromRGBO(0, 162, 233, 1),
                      ),
                    textAlign: TextAlign.center,
                  ),

                  TextButton(
                    onPressed: () {}, 
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: const Color.fromRGBO(0, 162, 233, 1),
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        decorationColor: const Color.fromRGBO(0, 162, 233, 1)
                        ),
                      textAlign: TextAlign.center,
                      )
                  )
                  ],
                ) :
                
                Form(
                  key: _formKey, 
                child: Column(
                    children: [
                      Text(
                      "Set Your Password",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(0, 162, 233, 1),
                        ),
                      textAlign: TextAlign.center,
                    ),

                    Padding(padding: EdgeInsets.all(8.0)),
                    
                    FractionallySizedBox(
                      widthFactor: 0.95,
                      child: Text(
                        "Set a strong password (6–12 characters) using letters, numbers, and symbols like @ _ #",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.blueGrey
                          ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(8.0)),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_pwdVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _pwdVisible = !_pwdVisible;
                            });
                          }, 
                          icon: Icon(_pwdVisible ? Icons.visibility : Icons.visibility_off)
                          )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),

                    Padding(padding: EdgeInsets.all(8.0)),

                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_confirmPwdVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _confirmPwdVisible = !_confirmPwdVisible;
                            });
                          }, 
                          icon: Icon(_confirmPwdVisible ? Icons.visibility : Icons.visibility_off)
                          )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password again';
                        }  else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    Padding(padding: EdgeInsets.all(8.0)),

                    SizedBox(
                      width: double.infinity, 
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SummaryScreen())
                          );
                          }   
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(0, 162, 233, 1),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Let\'s Go',
                          style: TextStyle(
                            color: Colors.white,
                          ), // White text for contrast
                        ),
                      ),
                    ),
                    ],
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}