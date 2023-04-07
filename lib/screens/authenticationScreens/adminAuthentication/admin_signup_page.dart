import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfspot/components/buttonComponents/login_button.dart';
import 'package:shelfspot/components/buttonComponents/signup_text_button.dart';
import 'package:shelfspot/components/textFieldComponents/password_text_field.dart';
import 'package:shelfspot/components/textFieldComponents/text_input_field.dart';
import 'package:shelfspot/screens/authenticationScreens/login_page.dart';

class AdminSignUpPage extends StatefulWidget {
  const AdminSignUpPage({Key? key}) : super(key: key);

  @override
  State<AdminSignUpPage> createState() => _AdminSignUpPageState();
}

class _AdminSignUpPageState extends State<AdminSignUpPage> {
  late TextEditingController _emailController;
  late TextEditingController _collageController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _collageController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _collageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201F15),
      appBar: AppBar(
        backgroundColor: const Color(0xFF201F15),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/applogo.png'),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextInputField(
                  text: ' Email Address',
                  controller: _emailController,
                  iconData: FontAwesomeIcons.envelope,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextInputField(
                  text: ' Collage Name',
                  controller: _emailController,
                  iconData: FontAwesomeIcons.graduationCap,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordTextField(
                  text: 'Enter password',
                  controller: _passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordTextField(
                  text: 'Confirm  password',
                  controller: _confirmPasswordController,
                ),
              ),
              SizedBox(
                height: 80,
                width: 200,
                child: LoginButton(
                  text: 'Sign Up',
                  onPressed: (){},
                ),
              ),

          SignUpTButton(
            text1: 'Already Sign up?',
            text2: 'Login Here',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LogInPage()));
            },
          ),
            ],
          ),
        ),
      ),
    );
  }
}
