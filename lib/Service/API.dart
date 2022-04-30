import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
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

  Future <UserModel> getUserInfo(String email, String password) async {
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
      UserModel user = UserModel.fromJson(body['user']);
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

  Future <List<TeacherModel>> getTeachers(String token) async {
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
      log("from api: " + teacher.isFavorite.toString());
      log("from api: " + teacherId);
      return teacher;
    });
  }
}