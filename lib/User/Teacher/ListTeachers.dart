import 'package:flutter_svg/svg.dart';
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
  late List lessons;

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Lesson lesson) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: const EdgeInsets.only(right: 12.0),
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24)),
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/1.jpg'),
              )),
          title: Text(
            lesson.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                    child: Text(lesson.level,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {},
        );

    Card makeCard(Lesson lesson) => Card(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(lesson),
          ),
        );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(lessons[index]);
        },
      ),
    );

    final listFilter = Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 4,
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
                  child: const Text("Button text"),
              ));
            }));

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
                const SizedBox(height: 30),
                const Text("Hey Alex,", style: kHeadingextStyle),
                const Text("Find a teacher", style: kSubheadingextStyle),
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
                const SizedBox(height: 30),
                Container(
                  height: 30,
                  child:listFilter,
                ),
                const SizedBox(height: 10),
                Expanded(child: makeBody)
              ],
            )));
  }
}

List getLessons() {
  return [
    Lesson(
        title: "Introduction to Driving",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 20,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Observation at Junctions",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Reverse parallel Parking",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Reversing around the corner",
        level: "Intermidiate",
        indicatorValue: 0.66,
        price: 30,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Incorrect Use of Signal",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Engine Challenges",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Lesson(
        title: "Self Driving Car",
        level: "Advanced",
        indicatorValue: 1.0,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
  ];
}
