import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mobile/Model/BookingModel.dart';
import 'package:mobile/Model/CourseModel.dart';
import 'package:mobile/Model/TeacherModel.dart';

import '../Model/UserModel.dart';


class ApiService {
  Future<String> getToken(String email, String password) async {
    return http.post(Uri.parse("https://sandbox.api.lettutor.com/auth/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password
        })
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      String token = "";
      if (statusCode != 200) {
        log(token);
        return token;
      }

      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      token = body['tokens']['access']['token'];
      return token;
    });
  }

  Future <UserModel?> getUserInfo(String email, String password) async {
    return http.post(Uri.parse("https://sandbox.api.lettutor.com/auth/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password
        })
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        throw Exception(
            "StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }

      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      UserModel user = UserModel.fromJson(body["user"]);
      return user;
    });
  }

  Future <List<CourseModel>> getCourse(String token) async {
    return http.get(
      Uri.parse("https://sandbox.api.lettutor.com/course?page=1&size=100"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        throw Exception(
            "StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }

      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      final List courseContainer = body['data']['rows'];
      List<CourseModel> courses = courseContainer.map((contactRaw) => CourseModel.fromJson(contactRaw)).toList();
      return courses;
    });
  }

  Future <CourseModel> getCourseDetail(String courseId, String token) async {
    return http.get(
      Uri.parse("https://sandbox.api.lettutor.com/course/" + courseId),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        throw Exception(
            "StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }
      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      CourseModel courses = CourseModel.fromJson(body['data']);
      return courses;
    });
  }

  Future <List<TopicModel>> getTopics(String courseId, String token) async {
    return http.get(
      Uri.parse("https://sandbox.api.lettutor.com/course/" + courseId),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        throw Exception(
            "StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }
      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      final List topicContainer = body['data']['topics'];
      List<TopicModel> topics = topicContainer.map((contactRaw) => TopicModel.fromJson(contactRaw)).toList();
      return topics;
    });
  }

  Future <List<TeacherModel>>? getTeachers(String token) async {
    return http.get(
      Uri.parse("https://sandbox.api.lettutor.com/tutor/more?perPage=10&page=1"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        throw Exception(
            "StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }

      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      final List teacherContainer = body['tutors']['rows'];
      List<TeacherModel> teachers = teacherContainer.map((contactRaw) => TeacherModel.fromJson(contactRaw)).toList();
      log("API: Teacher" );
      return teachers;
    });
  }

  Future <TeacherDetailModel> getTeacherDetail(String teacherId, String token) async {
    return http.get(
      Uri.parse("https://sandbox.api.lettutor.com/tutor/" + teacherId),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        throw Exception(
            "StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }

      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      TeacherDetailModel teacher = TeacherDetailModel.fromJson(body);
      return teacher;
    });
  }

  Future <String> updateUserInformation (String token, String name, String country, String phone, String birthday) async {
    return http.put(
      Uri.parse("https://sandbox.api.lettutor.com/user/info"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token
      },
      body: {

      }
    ).then((http.Response response) {
      if (response.statusCode != 200) {
        throw Exception("Something went wrong");
      }
      return "Success";
    });
  }

  Future <String> registerAccount(String email, String password) async {
    return http.post(Uri.parse("https://sandbox.api.lettutor.com/auth/register"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password
        })
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      String token = "";

      if (statusCode != 200) {
        const JsonDecoder _decoder = JsonDecoder();
        final body = _decoder.convert(jsonBody);
        token = body['statusCode'];
        return token;
      }

      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      token = body['tokens']['access']['token'];
      return token;
    });
  }

  Future <String> resetPassword (String email) async {
    return http.post(Uri.parse("https://sandbox.api.lettutor.com/user/forgotPassword"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        })
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;
      String message = "";

      if (statusCode != 200) {
        const JsonDecoder _decoder = JsonDecoder();
        final body = _decoder.convert(jsonBody);
        message = body['message'];
        return message;
      }

      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      message = body['message'];
      return message;
    });
  }

  Future <List<BookingModel>>? todayBooking(String token) async {
    return http.get(
      Uri.parse("https://sandbox.api.lettutor.com/booking/list/student"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token
      },
    ).then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200) {
        throw Exception(
            "StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }
      const JsonDecoder _decoder = JsonDecoder();
      final body = _decoder.convert(jsonBody);
      final List scheduleContainer = body['data']['rows'];
      List<BookingModel> schedules = scheduleContainer.map((contactRaw) => BookingModel.fromJson(contactRaw)).toList();
      return schedules;
    });
  }
}