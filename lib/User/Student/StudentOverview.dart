import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile/Model/BookingModel.dart';
import 'package:mobile/Model/UserModel.dart';

import '../../Service/API.dart';

class HomePage extends StatefulWidget {
  const HomePage({
        Key? key,
        required this.student,
        required this.token,
        required this.date,
        required this.month,
        required this.day
      }) : super(key: key);

  final UserModel? student;
  final String token;
  final String date;
  final String month;
  final String day;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<BookingModel>? listBooking;
  late String date = "";
  late String month = "";
  late String day = "";
  BookingModel temp = BookingModel(
      tutorId: "tutorId",
      date: "date",
      startTime: "startTime",
      tutorName: "tutorName",
      tutorAvatar: "tutorAvatar"
  );

  @override
  void initState() {
    super.initState();
    date = widget.date;
    month = widget.month;
    day = widget.day;
    _getBookingList();
  }

  void _getBookingList() async {
    listBooking = (await ApiService().todayBooking(widget.token));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFD4E7FE), Color(0xFFF0F0F0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 0.3])),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                      text: date,
                      style: const TextStyle(
                          color: Color(0XFF263064),
                          fontSize: 12,
                          fontWeight: FontWeight.w900),
                      children: [
                        TextSpan(
                          text: " $day $month",
                          style: const TextStyle(
                              color: Color(0XFF263064),
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                        )]),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.2),
                          blurRadius: 12,
                          spreadRadius: 8,
                        )],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage (widget.student!.avatar)
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        "Hi " + widget.student!.name,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Color(0XFF343E87),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Here is a list of schedule",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "You have learned 3 hours",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  )],
              )],
          ),
        ),
        Positioned(
          top: 185,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height - 245,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListView(
              children: [
                buildTitleRow("TODAY CLASSES ", listBooking == null ? 0 :listBooking!.length),
                const SizedBox(height: 20),
                buildClassItem(listBooking == null ? temp : listBooking![0]),
                buildClassItem(listBooking == null ? temp : listBooking![1]),
                const SizedBox(height: 25),
                buildTitleRow("YOUR TASKS", 4),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildTaskItem(3, "The Basic of Typography II", Colors.red),
                      buildTaskItem(3, "Design Psychology: Principle of...", Colors.green),
                      buildTaskItem(3, "Design Psychology: Principle of...", Colors.green),
                    ],
                  ),
                )],
            ),
          ),
        )],
    );
  }

  Container buildTaskItem(int numDays, String courseTitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Deadline", style: TextStyle(fontSize: 10, color: Colors.grey)),
          const SizedBox(height: 5),
          Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "$numDays days left",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 100,
            child: Text(
              courseTitle,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Row buildTitleRow(String title, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [TextSpan(
                  text: "($number)",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        const Text(
          "See all",
          style: TextStyle(
              fontSize: 12,
              color: Color(0XFF3E3993),
              fontWeight: FontWeight.bold),
        )],
    );
  }

  Container buildClassItem(BookingModel booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[Text(booking.startTime, style: const TextStyle(fontWeight: FontWeight.bold))],
          ),
          Container(
            height: 100,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: const Text("The Basic of Typography II", overflow: TextOverflow.ellipsis),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: const Text(
                      "Room C1, Faculty of Art & Design Building",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )],
              ),
              Row(
                children:[
                  CircleAvatar(
                    backgroundImage: NetworkImage(booking.tutorAvatar),
                    radius: 10,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    booking.tutorName,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  )],
              ),
            ],
          )],
      ),
    );
  }
}