import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelfspot/screens/authenticationScreens/login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0;

  void onTapBNB(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201F15),
      appBar: AppBar(
        backgroundColor: const Color(0xFF201F15),
        elevation: 0,
        title: const Text('Shelf Spot Admin'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();

            pref.remove("email");
            pref.remove("collage");
            pref.remove("isAdmin");
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LogInPage()));
          },
          child: const Text('Log out'),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 5,
        backgroundColor: const Color(0xFFFFC700),
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.black,
          size: 32,
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house),
          label: 'home',
          backgroundColor: Colors.white12,
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.codePullRequest),
          label: 'Requests',
          backgroundColor: Colors.white12,
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.fileCircleQuestion),
          label: 'Qn papers',
          backgroundColor: Colors.white12,
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: 'profile',
          backgroundColor: Colors.white12,
        ),
      ],
      iconSize: 31,
      selectedFontSize: 18,
      selectedItemColor: const Color(0xFFFFC700),
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.shifting,
      elevation: 2,
      currentIndex: _currentIndex,
      onTap: onTapBNB,
    );
  }
}
