import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/Courses/CourseDetail.dart';
import 'package:mobile/Model/CourseModel.dart';
import '../Service/API.dart';
import 'config.dart';

class ListCoursesWidget extends StatefulWidget {
  const ListCoursesWidget({Key? key, required this.token, required this.username}) : super(key: key);

  final String token;
  final String username;

  @override
  _ListCoursesWidgetState createState() => _ListCoursesWidgetState();
}


class _ListCoursesWidgetState extends State<ListCoursesWidget> {

  late String accessToken;

  late List<CourseModel> courses = [];
  List searchResult = [];
  bool _isSearching = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    accessToken = widget.token;
    _getCourses();
  }

  _ListCoursesWidgetState() {
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

  void _getCourses() async {
    courses = (await ApiService().getCourse(accessToken));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    if (_isSearching == true) {
      for (int i = 0; i < courses.length; i++) {
        CourseModel data = courses[i];
        if (data.name.toLowerCase().contains(searchText.toLowerCase())) {
          searchResult.add(data);
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    final makeBody = StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(0),
      crossAxisCount: 2,
      itemCount: courses.length,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image: NetworkImage(courses[index].imageUrl),
                  fit: BoxFit.fill,
                  opacity: 0.5
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(courses[index].name, style: const TextStyle(
                  fontSize: 16,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                )),
              ],
            ),
          ),
          onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CourseDetailWidget(
                  courseId: courses[index].id,
                  token: accessToken
              )),
            );
          },
        );
      },
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
    );

    final makeSearchBody = StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(0),
      crossAxisCount: 2,
      itemCount: searchResult.length,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image: NetworkImage(searchResult[index].imageUrl),
                  fit: BoxFit.fill,
                  opacity: 0.5
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(searchResult[index].name, style: const TextStyle(
                  fontSize: 16,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                )),
              ],
            ),
          ),
          onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CourseDetailWidget(
                  courseId: searchResult[index].id,
                  token: accessToken
              )),
            );
          },
        );
      },
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Text("Hey ${widget.username},", style: kHeadingextStyle),
            const Text("Find a course you want to learn", style: kSubheadingextStyle),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text("Courses", style: kTitleTextStyle),
                Text(
                  "See All",
                  style: kSubtitleTextStyle.copyWith(color: kBlueColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: searchResult.isNotEmpty || _controller.text.isNotEmpty ? makeSearchBody : makeBody),

          ],
        ),
      ),
    );
  }
}


