import 'dart:convert';

class TeacherModel {
  TeacherModel({
    required this.level,
    required this.email,
    required this.avatar,
    required this.name,
    required this.country,
    required this.phone,
    required this.birthday,
    required this.id,
    required this.userId,
    required this.videoUrl,
    required this.bio,
    required this.education,
    required this.experience,
    required this.profession,
    required this.targetStudent,
    required this.interests,
    required this.languages,
    required this.specialties,
    required this.price,
    required this.isOnline,
  });

  String level;
  String email;
  String avatar;
  String name;
  String country;
  String phone;
  String birthday;
  String id;
  String userId;
  String videoUrl;
  String bio;
  String education;
  String experience;
  String profession;
  String targetStudent;
  String interests;
  String languages;
  String specialties;
  int price;
  bool isOnline;

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        level: json["level"],
        email: json["email"],
        avatar: json["avatar"],
        name: json["name"],
        country: json["country"],
        phone: json["phone"],
        birthday: json["birthday"],
        id: json["id"],
        userId: json["userId"],
        videoUrl: json["video"],
        bio: json["bio"],
        education: json["education"],
        experience: json["experience"],
        profession: json["profession"],
        targetStudent: json["targetStudent"],
        interests: json["interests"],
        languages: json["languages"],
        specialties: json["specialties"],
        price: json["price"],
        isOnline: json["isOnline"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
      };
}

class TeacherDetailModel {
  TeacherDetailModel({
    required this.isFavorite,
    required this.avgRating,
  });

  bool isFavorite;
  double avgRating;

  factory TeacherDetailModel.fromJson(Map<String, dynamic> json) => TeacherDetailModel(
    isFavorite: json["isFavorite"],
    avgRating: double.parse(json["avgRating"].toString()),
  );

}