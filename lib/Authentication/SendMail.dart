import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/Service/API.dart';

import '../Utils/DialogWidget.dart';
import 'login.dart';

class SendMailWidget extends StatefulWidget {
  const SendMailWidget({Key? key}) : super(key: key);

  @override
  _SendMailWidgetState createState() => _SendMailWidgetState();
}

class _SendMailWidgetState extends State<SendMailWidget> {

  String? inputEmail;
  final formStateKey = GlobalKey<FormState>();

  String? validateEmail (String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    } else {
      return null;
    }
  }

  void saveEmail(String? email) {
    inputEmail = email;
  }

  void submitForm() async {
    if (formStateKey.currentState?.validate() == true) {
      formStateKey.currentState!.save();
      String message = (await ApiService().resetPassword(inputEmail!));
      if(message == "Email send success!") {
        final action = await ViewDialogs.yesOrNoDialog(
          context,
          'Notification',
          'Check your mail and follow instruction to reset your password.',
        );
        if (action == ViewDialogsAction.yes) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginWidget()),
                  (route) => false
          );
        }
      } else if (message == "Email doesn't exist!") {
        final action = await ViewDialogs.yesOrNoDialog(
          context,
          'Notification',
          "Email doesn't exist! Please check again.",
        );
        if (action == ViewDialogsAction.yes) {
          setState(() {});
        }
      } else {
        setState(() {});
      }
    } else {
      setState(() {});
    }
  }

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
                    Form(
                      key: formStateKey,
                      child: SizedBox(
                        width: 360,
                        height: 60,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              suffix: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.red,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                              )),
                          validator: validateEmail,
                          onSaved: saveEmail,
                        ),
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
                            onPressed: (){submitForm();},
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
