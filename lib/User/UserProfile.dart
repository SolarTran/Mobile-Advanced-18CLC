import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mobile/Authentication/login.dart';
import 'package:mobile/User/UserAppSettings.dart';
import 'UserProfileScreenConfiguration.dart';
import 'package:flutter_svg/svg.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserProfile()
    );
  }
}

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppPrimaryColor,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 10),
            child: Column(
              children: const <Widget>[
                AvatarImage(),
                SizedBox(height: 15),
                SocialIcons(),
                SizedBox(height: 5),
                Text(
                  'Sang',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins"),
                ),
                Text(
                  '@amFOSS',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 5),
                Text(
                  'Mobile App Developer and Open source enthusiastic',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontFamily: "Poppins"),
                ),
                SizedBox(height: 5),
                ProfileListItems(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData icon;

  const AppBarButton({Key? key, required this.icon}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kAppPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: kLightBlack,
              offset: const Offset(1, 1),
              blurRadius: 10,
            ),
            BoxShadow(
              color: kWhite,
              offset: const Offset(-1, -1),
              blurRadius: 10,
            ),
          ]),
      child: Icon(
        icon,
        color: fCL,
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  const AvatarImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: avatarDecoration,
      child: Container(
        decoration: avatarDecoration,
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/user.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class SocialIcons extends StatelessWidget {
  const SocialIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          color: const Color(0xFF102397),
          iconData: facebook,
          onPressed: () {},
        ),
        SocialIcon(
          color: const Color(0xFFff4f38),
          iconData: googlePlus,
          onPressed: () {},
        ),
        SocialIcon(
          color: const Color(0xFF38A1F3),
          iconData: twitter,
          onPressed: () {},
        ),
        SocialIcon(
          color: const Color(0xFF2867B2),
          iconData: linkedin,
          onPressed: () {},
        )
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final Function onPressed;

  const
  SocialIcon(
      {Key? key, required this.color, required this.iconData, required this.onPressed}
  ): super (key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        width: 45.0,
        height: 40.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          onPressed: (){},
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(text == 'Settings'){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserAppSettingsScreen())
          );
        }
        if(text == 'Logout'){
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginWidget()),
            (route) => false
          );
        }
      },
      child:Container(
        height: 55,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.shade300,
        ),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 25),
            const SizedBox(width: 15),
            Text(text,
              style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins"
              ),
            ),
            const Spacer(),
            if (hasNavigation)
              const Icon(LineAwesomeIcons.angle_right, size: 25),
          ],
        ),
      )
    );
  }
}

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ListView(
          children: const <Widget>[
            ProfileListItem(
              icon: LineAwesomeIcons.user_shield,
              text: 'Privacy',
            ),
            ProfileListItem(
              icon: LineAwesomeIcons.history,
              text: 'Purchase History',
            ),
            ProfileListItem(
              icon: LineAwesomeIcons.question_circle,
              text: 'Help & Support',
            ),
            ProfileListItem(
              icon: LineAwesomeIcons.cog,
              text: 'Settings',
            ),
            ProfileListItem(
              icon: LineAwesomeIcons.user_plus,
              text: 'Invite a Friend',
            ),
            ProfileListItem(
              icon: LineAwesomeIcons.alternate_sign_out,
              text: 'Logout',
              hasNavigation: false,
            ),
          ],
        ),
      )
    );
  }
}

