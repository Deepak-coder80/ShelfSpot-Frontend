import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfspot/screens/usersPages/adminPages/admin_book_page.dart';
import 'package:shelfspot/screens/usersPages/adminPages/admin_profile_page.dart';
import 'package:shelfspot/screens/usersPages/adminPages/admin_qn_paper_page.dart';
import 'package:shelfspot/screens/usersPages/adminPages/admin_request_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0;

  final List _pages = const [
    AdminBookPage(),
    AdminRequestScreen(),
    AdminQnPaperScreen(),
    AdminProfileScreen(),
  ];

  void onTapBNB(index) {
    if(index >= _pages.length){
      return;
    }
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
      body:_pages[_currentIndex],
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
          icon: Icon(FontAwesomeIcons.bookAtlas),
          label: 'books',
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
