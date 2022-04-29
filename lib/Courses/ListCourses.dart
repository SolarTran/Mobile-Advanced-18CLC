import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile/Courses/CourseDetail.dart';
import 'package:mobile/Courses/CourseModel.dart';
import 'package:mobile/User/UserProfile.dart';
import '../Service/API.dart';
import 'config.dart';

class ListCoursesWidget extends StatefulWidget {
  const ListCoursesWidget({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  _ListCoursesWidgetState createState() => _ListCoursesWidgetState();
}


class _ListCoursesWidgetState extends State<ListCoursesWidget> {

  late String accessToken;

  late List<CourseModel> courses = [];

  @override
  void initState() {
    super.initState();
    accessToken = widget.token;
    _getCourses();
  }

  void _getCourses() async {
    courses = (await ApiService().getCourse(accessToken));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Image.asset("assets/images/2.png"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const UserProfileWidget())
                    );
                  }),
              ],
            ),
            const Text("Hey Alex,", style: kHeadingextStyle),
            const Text("Find a course you want to learn", style: kSubheadingextStyle),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
            Expanded(
              child: StaggeredGridView.countBuilder(
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
              ),
            ),

          ],
        ),
      ),
    );
  }
}


