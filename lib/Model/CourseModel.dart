import 'dart:convert';

List<CourseModel> courseModelFromJson(String str) =>
    List<CourseModel>.from(json.decode(str).map((x) => CourseModel.fromJson(x)));

String courseModelToJson(List<CourseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseModel {
  CourseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    required this.reason,
    required this.purpose,
    required this.defaultPrice,
    required this.coursePrice,
    required this.createdAt,
    required this.updatedAt
  });

  String id;
  String name;
  String description;
  String imageUrl;
  String level;
  String reason;
  String purpose;
  String createdAt;
  String updatedAt;
  int defaultPrice;
  int coursePrice;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      level: json["level"],
      reason: json["reason"],
      purpose: json["purpose"],
      defaultPrice: json["default_price"],
      coursePrice: json["course_price"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "imageUrl": imageUrl,
    "level": level,
    "reason": reason,
    "purpose": purpose,
    "default_price": defaultPrice,
    "course_price": coursePrice,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class TopicModel {
  TopicModel({
    required this.id,
    required this.courseId,
    required this.orderCourse,
    required this.name,
    required this.nameFile,
    required this.description,
    required this.createdAt,
    required this.updatedAt
  });
  String id;
  String courseId;
  int orderCourse;
  String name;
  String nameFile;
  String description;
  String createdAt;
  String updatedAt;

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    id: json["id"],
    courseId: json["courseId"],
    orderCourse: json["orderCourse"],
    name: json["name"],
    nameFile: json["nameFile"],
    description: json["description"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "courseId": courseId,
    "orderCourse": orderCourse,
    "name": name,
    "nameFile": nameFile,
    "description": description,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}