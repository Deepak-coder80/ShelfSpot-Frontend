import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfspot/screens/usersPages/studentPages/student_book_page.dart';
import 'package:shelfspot/screens/usersPages/studentPages/student_profile_page.dart';
import 'package:shelfspot/searchScreens/qn_paper_search.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _currentIndex = 0;

  final List _pages = const [
    StudentBookPage(),
    QnPaperSearchScreen(),
    StudentProfileScreen(),
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
        title: const Text('Shelf Spot Student'),
      ),
      body: _pages[_currentIndex],
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
          icon: Icon(FontAwesomeIcons.book),
          label: 'books',
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
