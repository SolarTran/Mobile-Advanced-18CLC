import 'package:flutter/material.dart';
import 'Authentication/login.dart';
import 'Authentication/signup.dart';


void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: Colors.purple,
  ),
  title: "Login App",
  home: const LoginWidget(),
));

