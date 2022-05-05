import 'dart:developer';

import 'package:flutter_svg/svg.dart';
import 'package:mobile/Model/TeacherModel.dart';
import 'package:mobile/User/Teacher/TeacherDetail.dart';
import 'config.dart';
import 'package:flutter/material.dart';

class ListTeachersScreen extends StatefulWidget {
  const ListTeachersScreen({Key? key, required this.teachers, required this.token}) : super(key: key);

  final List<TeacherModel>? teachers;
  final String? token;

  @override
  _ListTeachersScreenState createState() => _ListTeachersScreenState();
}

class _ListTeachersScreenState extends State<ListTeachersScreen> {
  List<TeacherModel>? teachers;
  late String accessToken;
  final List<String> filters = <String>['PETS', 'IETLS', 'TOEIC', 'TOEFL'];
  List searchResult = [];
  bool _isSearching = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    teachers = widget.teachers;
    accessToken = widget.token!;
  }

  _ListTeachersScreenState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    if (_isSearching == true) {
      for (int i = 0; i < teachers!.length; i++) {
        TeacherModel data = teachers![i];
        if (data.name.toLowerCase().contains(searchText.toLowerCase())) {
          searchResult.add(data);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(TeacherModel teacher) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: const EdgeInsets.only(right: 12.0),
              decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24)),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(teacher.avatar),
              )),
          title: Text(teacher.name,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 4,
                  child: Text(teacher.country,
                      style: const TextStyle(color: Colors.white)))
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TeacherDetailScreen(
                  token: accessToken,
                  id: teacher.userId,
                  teacher: teacher
                )));
          },
        );

    Card makeCard(TeacherModel teacher) => Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 1),
          ),
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(64, 75, 96, .9),
                borderRadius: BorderRadius.circular(25)),
            child: makeListTile(teacher),
          ),
        );

    final makeBody = ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: teachers!.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(teachers![index]);
      },
    );

    final makeSearchBody = ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: searchResult.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(searchResult[index]);
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Search for something",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFFA0A5BD),
                        ),
                        onChanged: searchOperation,
                        onTap: () {
                          setState(() {
                            _isSearching = true;
                          });
                        }
                      ),
                    )
                ),
                const SizedBox(height: 20),
                SizedBox(height: 30, child: listFilter),
                const SizedBox(height: 20),
                Flexible(child: searchResult.isNotEmpty || _controller.text.isNotEmpty ? makeSearchBody : makeBody)
              ],
            )));
  }
}
