import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/Authentication/ForgotPassword.dart';
import 'package:mobile/Authentication/SignUp.dart';
import 'package:mobile/Dashboard.dart';
import '../Service/API.dart';
import '../Model/UserModel.dart';
import '../Utils/DialogWidget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);


  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}


class _LoginWidgetState extends State<LoginWidget> {

  UserModel? user;
  late String token;
  late String inputUsername;
  late String inputPassword;

  String? validateUsername (String? username) {
    if (username == null || username.isEmpty) {
      return 'Email cannot be empty';
    } else {
      return null;
    }
  }

  String? validatePassword (String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    } else {
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
  void _getUserInfo() async {
    user = (await ApiService().getUserInfo(inputUsername, inputPassword));
  }

  void submitForm() async {
    if (formStateKey.currentState?.validate() != null) {
      formStateKey.currentState!.save();
      token = (await ApiService().getToken(inputUsername, inputPassword));
      if(token != "") {
        _getUserInfo();
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Dashboard(token: token, user: user)));
        });
      }
      else {
        await ViewDialogs.yesOrNoDialog(
          context,
          'Notification',
          'Incorrect username or password.',
        );
      }
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
              Container(
                width: 325,
                height: 440,
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
                      "Please Login to Your Account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    Form(
                      key: formStateKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
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
                          const SizedBox(height: 20),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SendMailWidget())
                              );
                            },
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                          )],
                      ),
                    ),
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
                              child: const Text('Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            onPressed: submitForm,
                          )),
                      ),
                    ),
                    const SizedBox(height: 12),
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
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const SignUpWidget()),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            ),
                          )),
                      ),
                    ),
                  ],
                ),
              )],
          ),
        ),
      ),
    );
  }
}
