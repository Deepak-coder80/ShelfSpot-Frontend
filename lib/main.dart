import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelfspot/screens/authenticationScreens/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shelfspot/screens/usersPages/adminPages/admin_home.dart';
import 'screens/usersPages/studentPages/student_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString('email');
  var isAdmin = pref.getBool('isAdmin');
  await dotenv.load(fileName: ".env");
  runApp(MyApp(email: email, isAdmin: isAdmin));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.email,
    required this.isAdmin,
  });

  final String? email;
  final bool? isAdmin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHELF SPOT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: email != null
          ? (isAdmin == true ? const AdminHomePage() : const StudentHomePage())
          : const LogInPage(),
    );
  }
}
