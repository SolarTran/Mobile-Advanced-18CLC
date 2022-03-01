import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.size,
    required this.text,
    required this.press,
  }) : super(key: key);

  final Size size;
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.35),
        child: SizedBox(
          width: size.width * 0.5,
          height: 50.0,
          child: RaisedButton(
            elevation: 10.0,
            color: const Color(0xFF4A90E2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: const BorderSide(color: Color(0xFF4A90E2)),
            ),
            onPressed: press,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
                Card(
                  color: const Color(0xCDA3C5EC),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0)),
                  child: const SizedBox(
                    width: 35.0,
                    height: 35.0,
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class OtpVerificationBody extends StatelessWidget {
  const OtpVerificationBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Lottie.asset(
            "assets/lottie/otpverification.json",
            height: 250,
            width: 250,
          ),
        ),
        const SizedBox(height: 20),
        Stack(
          children: [
            Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                    offset: const Offset(2.0, 5.0),
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10.0,
                margin: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40.0),
                      padding: const EdgeInsets.all(20.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Verification\n\n",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0278AE),
                              ),
                            ),
                            TextSpan(
                              text: "Enter the OTP send to your mobile number",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF373A40),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(50,0,50,0),
                      child: PinInputTextField(
                        pinLength: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Button(
              size: size,
              text: "Continue",
              press: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: OtpVerificationBody(size: size),
    );
  }
}
