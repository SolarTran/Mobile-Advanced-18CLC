import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/Courses/ListCourses.dart';
import 'package:mobile/Model/UserModel.dart';
import 'package:mobile/User/Student/StudentOverview.dart';
import 'package:mobile/User/Student/StudentSchedule.dart';
import 'package:mobile/User/Teacher/ListTeachers.dart';
import 'package:mobile/User/UserProfile.dart';

import 'Model/TeacherModel.dart';
import 'Service/API.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.token, required this.user}) : super(key: key);
  final String token;
  final UserModel? user;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  List<TeacherModel>? teachers;
  List<Widget>? _widgetOptions;
  String? date = "";
  String? month = "";
  String? day = "";
  @override
  void initState() {
    super.initState();
    _getTeachers();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    var temp = DateTime.now().toUtc();
    date = DateFormat('EEEEE', 'en_US').format(temp);
    month = DateFormat('MMMM', 'en_US').format(temp);
    day = DateFormat('d', 'en_US').format(temp);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  void _getTeachers() async {
    teachers = (await ApiService().getTeachers(widget.token));
    _widgetOptions = <Widget>[
      ListCoursesWidget(token: widget.token),
      ListTeachersScreen(token: widget.token, teachers: teachers),
      HomePage(
        student: widget.user,
        token: widget.token,
        date: date!,
        month: month!,
        day: day!,
      ),
      const CalendarPage(),
      UserProfileWidget(userInfo: widget.user, token: widget.token)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions == null ? ListCoursesWidget(token: widget.token): _widgetOptions!.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Teacher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            label: "Schedule",
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.menu),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
        onTap: _onItemTapped,
      ),
    );
  }
}