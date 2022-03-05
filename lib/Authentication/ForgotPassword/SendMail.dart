import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'OtpVerify.dart';

class SendMailWidget extends StatelessWidget {
  const SendMailWidget({Key? key}) : super(key: key);

  void click() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Row(
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                    onPressed: () {
                      Navigator.pop(context);
                    },)
                ]
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 325,
                height: 450,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Reset Password",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Enter the email associated with your account and we'll send and email with OTP to reset your password ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Email Address",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,

                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(
                      width: 360,
                      height: 60,
                      child: TextField(
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.red,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            )),
                      ),
                    ),
                    const SizedBox(height: 35),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 360,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF8A2387),
                                  Color(0xFFE94057),
                                  Color(0xFFF27121),
                                ])),
                        child: SizedBox(
                          child: TextButton(
                          child: const Text(
                            'Request OTP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const VerifyOtpScreen()),
                              );
                            },
                        ))
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
