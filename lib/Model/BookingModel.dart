import 'dart:convert';

class BookingModel {
  BookingModel({
    required this.tutorId,
    required this.date,
    required this.startTime,
    required this.tutorName,
    required this.tutorAvatar,
  });

  String date;
  String tutorId;
  String startTime;
  String tutorName;
  String tutorAvatar;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    tutorId: json["scheduleDetailInfo"]["scheduleInfo"]["tutorId"],
    date: json["scheduleDetailInfo"]["scheduleInfo"]["date"],
    startTime: json["scheduleDetailInfo"]["scheduleInfo"]["startTime"],
    tutorName: json["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["name"],
    tutorAvatar: json["scheduleDetailInfo"]["scheduleInfo"]["tutorInfo"]["avatar"],
  );

}
