import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';

import '../Authentication/Login.dart';
import '../Model/UserModel.dart';
import 'EditProfile.dart';


class UserAppSettingsScreen extends StatefulWidget {
  const UserAppSettingsScreen({Key? key, required this.userInfo, required this.token}) : super(key: key);

  final String token;
  final UserModel? userInfo;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<UserAppSettingsScreen> {
  bool lockInBackground = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              },
            ),],
          ),
          Expanded(
            child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ListView(
              children: [
                SimpleUserCard(
                  userName: widget.userInfo!.name,
                  userProfilePic: NetworkImage(widget.userInfo!.avatar),
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.fingerprint,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.red,
                      ),
                      title: 'Privacy',
                      subtitle: "Lock LetTutor App to improve your privacy",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.dark_mode_rounded,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.red,
                      ),
                      title: 'Dark Mode',
                      subtitle: "Automatic",
                      trailing: Switch.adaptive(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: 'About',
                      subtitle: "Learn more about LetTutor App",
                    ),
                  ],
                ),

                SettingsGroup(
                  settingsGroupTitle: "Account",
                  items: [
                    SettingsItem(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const LoginWidget()),
                                (route) => false
                        );
                      },
                      icons: Icons.exit_to_app_rounded,
                      title: "Sign Out",
                    ),
                    SettingsItem(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EditProfilePage(
                            userInfo: widget.userInfo,
                            token: widget.token
                          )),
                        );
                      },
                      icons: CupertinoIcons.repeat,
                      title: "Change Information",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: CupertinoIcons.delete_solid,
                      title: "Delete Account",
                      titleStyle: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
          )
        ],
      )
    );
  }
}
