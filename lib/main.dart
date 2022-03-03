import 'package:flutter/material.dart';
import 'package:mobile/Authentication/ForgotPassword/OtpVerify.dart';
import 'Authentication/login.dart';
import 'Authentication/signup.dart';
import 'Authentication/ForgotPassword/SendMail.dart';
import 'Authentication/ForgotPassword/ResetPassword.dart';
import 'Authentication/ForgotPassword/OtpVerify.dart';
import 'Courses/CourseDetail.dart';
import 'Courses/ListCourses.dart';
import 'User/Teacher/ListTeachers.dart';
import 'User/UserAppSettings.dart';
import 'User/UserProfile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      home: ListTeachersScreen(title: 'Lessons'),
      // home: DetailPage(),
    );
  }
}



