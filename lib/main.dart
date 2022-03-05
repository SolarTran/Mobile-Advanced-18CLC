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
import 'User/Teacher/TeacherBookingDetails.dart';
import 'User/Teacher/TeacherDetail.dart';
import 'User/Teacher/TeacherSchedule.dart';
import 'User/Teacher/doctor_model.dart';
import 'User/UserAppSettings.dart';
import 'User/UserProfile.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SingleHotel(),
    );
  }
}



