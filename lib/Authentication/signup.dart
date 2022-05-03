import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Service/API.dart';
import '../Utils/DialogWidget.dart';
import 'login.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}


class _SignUpWidgetState extends State<SignUpWidget> {

  String? token;
  String? inputUsername;
  String? inputPassword;

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String? validateUsername (String? username) {
    if (username == null || username.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(username)) {
      return 'Email is invalid';
    } else {
      return null;
    }
  }

  String? validatePassword (String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length <6) {
      return 'Password length must be at least 6 characters long';
    }
    else {
      return null;
    }
  }

  String? validateConfirmPassword (String? inputConfirmPassword) {
    if (inputConfirmPassword == null || inputConfirmPassword.isEmpty) {
      return 'Confirm password cannot be empty';
    } else if (inputConfirmPassword.length <6) {
      return 'Confirm password length must be at least 6 characters long';
    } else if (password.text != confirmPassword.text) {
      return 'Confirm password doesn\'t match';
    }
    else {
      return null;
    }
  }

  void saveUsername(String? username) {
    inputUsername = username!;
  }

  void savePassword(String? password) {
    inputPassword = password!;
  }

  final formStateKey = GlobalKey<FormState>();

  void submit() async {
    if (formStateKey.currentState?.validate() == true) {
      formStateKey.currentState!.save();
      token = (await ApiService().registerAccount(inputUsername!, inputPassword!));
      log("From signup: " + formStateKey.currentState!.validate().toString());
      if(token != "" && token !="4") {
        final action = await ViewDialogs.yesOrNoDialog(
          context,
          'Notification',
          'Create account successfully. Please login',
        );
        if (action == ViewDialogsAction.yes) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginWidget()),
                  (route) => false
          );
        }
      } else if (token == "4") {
        final action = await ViewDialogs.yesOrNoDialog(
          context,
          'Notification',
          'Email has already taken',
        );
        if (action == ViewDialogsAction.yes) {
          setState(() {});
        }
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purpleAccent,
                    Colors.amber,
                    Colors.blue,
                  ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200,
                width: 300,
                child: LottieBuilder.asset("assets/lottie/login2.json"),
              ),
              const SizedBox(height: 10),
              Container(
                width: 325,
                height: 420,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "LetTutor",
                      style:
                      TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Please Create New Account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: formStateKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 260,
                            height: 60,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  suffix: Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.red,
                                  ),
                                  labelText: "Email Address",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                  )),
                              validator: validateUsername,
                              onSaved: saveUsername,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 260,
                            height: 60,
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                  suffix: Icon(
                                    FontAwesomeIcons.eyeSlash,
                                    color: Colors.red,
                                  ),
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                  )),
                              validator: validatePassword,
                              onSaved: savePassword,
                              controller: password
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 260,
                            height: 60,
                            child:  TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                  suffix: Icon(
                                    FontAwesomeIcons.eyeSlash,
                                    color: Colors.red,
                                  ),
                                  labelText: "Confirm Password",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                  )),
                              validator: validateConfirmPassword,
                              controller: confirmPassword
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
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
                              'Create',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              submit();
                            },
                          )

                        ),
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
