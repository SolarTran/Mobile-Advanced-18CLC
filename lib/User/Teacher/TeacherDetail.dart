import 'package:flutter/material.dart';
import 'package:mobile/Model/TeacherModel.dart';
import 'package:mobile/User/Teacher/progress_widget.dart';
import '../../Service/API.dart';
import 'light_color.dart';
import 'text_styles.dart';
import 'theme.dart';
import 'rating_star_widget.dart';
import 'extension.dart';



class TeacherDetailScreen extends StatefulWidget {
  const TeacherDetailScreen({Key? key, required this.token, required this.id, required this.teacher}) : super(key: key);

  final String token;
  final String id;
  final TeacherModel teacher;

  @override
  _TeacherDetailPageState createState() => _TeacherDetailPageState();
}

class _TeacherDetailPageState extends State<TeacherDetailScreen> {

  late String accessToken;
  late String teacherId;
  late TeacherModel teacher;
  late TeacherDetailModel teacherDetail;

  @override
  void initState() {
    super.initState();
    accessToken = widget.token;
    teacherId = widget.id;
    teacher = widget.teacher;
    _getTeacherDetail();
  }

  void _getTeacherDetail() async {
    teacherDetail = (await ApiService().getTeacherDetail(teacherId, accessToken));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Widget _appbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BackButton(color: Theme.of(context).primaryColor),
          IconButton(
            icon: Icon(
                teacherDetail.isFavorite? Icons.favorite : Icons.favorite_outline,
                color: Colors.red),
            onPressed: () {
              teacherDetail.isFavorite = !teacherDetail.isFavorite;
              setState(() {});
            },
          )],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.network(
              teacher.avatar,
              width: 980,
              height: 300,
            ),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: const EdgeInsets.only(
                    left: 19,
                    right: 19,
                    top: 16,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(teacher.name, style: titleStyle),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.check_circle,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: RatingStarWidget(rating: teacherDetail.avgRating),
                              ),
                            ],
                          ),
                          subtitle: Text(teacher.profession, style: TextStyles.bodySm.subTitleColor.bold),
                        ),
                        const Divider(thickness: .3, color: LightColor.grey),
                        Text("About", style: titleStyle).vP4,
                        Text(
                          teacher.bio,
                          style: const TextStyle(
                              color: LightColor.lightblack,
                              fontSize: 16
                          ),
                        ),
                        const Divider(thickness: .3, color: LightColor.grey),
                        Text("Specialities", style: titleStyle).vP4,
                        Text(
                          teacher.specialties,
                          style: const TextStyle(
                              color: LightColor.lightblack,
                              fontSize: 16
                          ),
                        ),
                        const Divider(thickness: .3, color: LightColor.grey),
                        Text("Interests", style: titleStyle).vP4,
                        Text(
                          teacher.interests,
                          style: const TextStyle(
                              color: LightColor.lightblack,
                              fontSize: 16
                          ),
                        ),
                        const Divider(thickness: .3, color: LightColor.grey),
                        Text("Languages", style: titleStyle).vP4,
                        Text(
                          teacher.languages, //== "en" ? "English" : "Japanese",
                          style: const TextStyle(
                              color: LightColor.lightblack,
                              fontSize: 16
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: const Icon(Icons.call, color: Colors.white),
                            ).ripple(() {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.grey.withAlpha(150),
                              ),
                              child: const Icon(Icons.chat_bubble, color: Colors.white),
                            ).ripple(() {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {},
                                child: Text("Make an appointment", style: TextStyles.titleNormal.white),
                              ),
                            ),
                          ],
                        ).vP16
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}