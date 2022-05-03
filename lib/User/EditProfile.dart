import 'dart:developer';
import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Model/UserModel.dart';
import 'package:mobile/Service/API.dart';
import 'package:mobile/Utils/ProfileWidget.dart';
import 'package:mobile/Utils/TextFieldWidget.dart';
import '../Utils/AppbarWidget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.userInfo, required this.token}) : super(key: key);

  final String token;
  final UserModel? userInfo;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  late String name;
  late String phone;
  late String country;
  late String birthday;

  void submitForm() async {
    String isSuccess = (await ApiService().updateUserInformation(
        widget.token, name, country, phone, birthday
    ));

  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher(
        builder: (context) => Scaffold(
              appBar: buildAppBar(context),
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30),
                physics: BouncingScrollPhysics(),
                children: [
                  ProfileWidget(
                    imagePath:
                        widget.userInfo!.avatar,
                    isEdit: true,
                    onClicked: () async {},
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    label: 'Full Name',
                    text: widget.userInfo!.name,
                    onChanged: (name) {
                      this.name = name;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'Country',
                    text: widget.userInfo!.country,
                    onChanged: (country) {
                      this.country = country;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    label: 'Phone',
                    text: widget.userInfo!.phone,
                    onChanged: (phone) {
                      this.phone = phone;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    label: 'Birthday',
                    text: widget.userInfo!.birthday,
                    onChanged: (birthday) {
                      this.birthday = birthday;
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: 250,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF8A2387),
                                Color(0xFFE94057),
                                Color(0xFFF27121),
                              ])),
                      child: SizedBox(
                          child: TextButton(
                            child: const Text('Change Information',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: (){

                            }//submitForm,
                          )),
                    ),
                  ),

                ],
              ),
            ));
  }
}
