import 'package:flutter_svg/svg.dart';
import 'package:mobile/User/Teacher/TeacherDetail.dart';
import 'config.dart';
import 'lesson.dart';
import 'package:flutter/material.dart';

class ListTeachersScreen extends StatefulWidget {
  const ListTeachersScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListTeachersScreenState createState() => _ListTeachersScreenState();
}

class _ListTeachersScreenState extends State<ListTeachersScreen> {
  late List teachers;
  final List<String> filters = <String>['PETS', 'IETLS', 'TOEIC', 'TOEFL'];
  @override
  void initState() {
    teachers = getTeachers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Teacher lesson) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: const EdgeInsets.only(right: 12.0),
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(width: 1.0, color: Colors.white24)),
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/1.jpg'),
              )),
          title: Text(
            lesson.name,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(lesson.tag, style: const TextStyle(color: Colors.white)))
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailScreen())
            );
          },
        );

    Card makeCard(Teacher lesson) => Card(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(lesson),
          ),
        );

    final makeBody = ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: teachers.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(teachers[index]);
      },
    );

    final listFilter = ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: filters.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 150,
            height: 5.0,
            margin: const EdgeInsets.only(right: 20.0),
            child: OutlinedButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
                ),
              child: Text(filters[index]),
          ));
        });

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/menu.svg"),
                    Image.asset("assets/images/2.png"),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Hey Alex,", style: kHeadingextStyle),
                const Text("Find a teacher", style: kSubheadingextStyle),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F7),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset("assets/icons/search.svg"),
                      const SizedBox(width: 16),
                      const Text(
                        "Search for anything",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFA0A5BD),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(height: 30, child:listFilter),
                const SizedBox(height: 20),
                Flexible(child: makeBody)
              ],
            )));
  }
}

List getTeachers() {
  return [
    Teacher(
        name: "Kathy Huỳnh",
        tag: "Beginner",
    ),
    Teacher(
        name: "Nhi Lam",
        tag: "Beginner",
    ),
    Teacher(
        name: "Albie Corpuz",
        tag: "Intermidiate",
    ),
    Teacher(
        name: "Jill Leano",
        tag: "Intermidiate",
    ),
    Teacher(
        name: "Caela",
        tag: "Advanced",
    ),
  ];
}
