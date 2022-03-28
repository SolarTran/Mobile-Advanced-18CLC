import 'package:flutter/material.dart';
import 'package:mobile/Courses/ListCourses.dart';
import 'package:mobile/User/Student/StudentOverview.dart';
import 'package:mobile/User/Student/StudentSchedule.dart';
import 'package:mobile/User/Teacher/ListTeachers.dart';
import 'package:mobile/User/UserAppSettings.dart';
import 'package:mobile/User/UserProfile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ListCoursesWidget(),
    ListTeachersScreen(title: "title"),
    HomePage(),
    CalendarPage(),
    UserProfileWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
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