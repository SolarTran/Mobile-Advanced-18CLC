import 'package:flutter/material.dart';
import 'package:mobile/Authentication/ForgotPassword/OtpVerify.dart';
import 'Authentication/login.dart';
import 'Authentication/signup.dart';
import 'Authentication/ForgotPassword/SendMail.dart';
import 'Authentication/ForgotPassword/ResetPassword.dart';
import 'Authentication/ForgotPassword/OtpVerify.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.purple,
  ),
  title: "Login App",
  home: const VerifyOtpScreen(),
));

