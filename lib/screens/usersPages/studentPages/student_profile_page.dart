import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelfspot/components/buttonComponents/login_button.dart';
import 'package:shelfspot/screens/authenticationScreens/login_page.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  String email='';
  String collage='';

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString('email') ?? '';
      collage = pref.getString('collage') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201F15),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              backgroundColor: Colors.white24,
              radius: 60,
              child: Icon(
                FontAwesomeIcons.user,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ProfileDetails(heading: 'Email : ', content: email),
            const SizedBox(
              height: 10,
            ),
            ProfileDetails(heading: 'Collage : ', content: collage),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              width: 200,
              child: LoginButton(
                text: 'Log Out',
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();

                  pref.remove("email");
                  pref.remove("collage");
                  pref.remove("isAdmin");
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LogInPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final String heading;
  final String content;

  const ProfileDetails({
    super.key,
    required this.heading,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            heading,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          )
        ],
      ),
    );
  }
}
