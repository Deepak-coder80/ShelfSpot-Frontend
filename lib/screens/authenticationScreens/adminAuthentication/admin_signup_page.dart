import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shelfspot/apiServices/admin_authentication_service.dart';
import 'package:shelfspot/components/alertboxes/alertbox.dart';
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

  Future<bool> fetchData() async {
    try {
      bool result = await APIAuthentication.signUpAdmin(
        _emailController.text,
        _collageController.text,
        _passwordController.text,
      );
      if (result == true) {
        return result;
      } else {
        throw Exception("Sign Up unsuccessful");
      }
    } catch (e) {
      rethrow;
    }
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
                  controller: _collageController,
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
                  onPressed: () async {
                    if (_emailController.text.isEmpty) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => const AlertBox(
                          title: 'Email Can\'t be Empty',
                          content: 'Please Enter a email',
                        ),
                      );
                    } else if (!EmailValidator.validate(
                        _emailController.text)) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => const AlertBox(
                          title: 'Please enter a valid email',
                          content: 'Email should be an existing one',
                        ),
                      );
                    } else if (_passwordController.text.length < 6) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => const AlertBox(
                          title: 'Please enter a valid password',
                          content: 'Password Should be 6 characters',
                        ),
                      );
                    } else if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      showDialog(
                        context: context,
                        builder: (context) => const AlertBox(
                          title: 'Password should match',
                          content: 'Password and confirm password should match',
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: LoadingIcon(),
                          );
                        },
                      );
                      fetchData().then(
                        (data) {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogInPage()),
                              (route) => false);
                          const snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Signed Up Successfully. Please Login'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ).catchError(
                        (e) {
                          Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) => const AlertBox(
                              title: 'Sign Up unsuccessful',
                              content:
                                  'Please check your credentials once again and Try again',
                            ),
                          );
                        },
                      );
                    }
                  },
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

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 90,
      width: 90,
      child: LoadingIndicator(
        indicatorType: Indicator.ballRotateChase,
        colors: [Color(0xFFFFC700)],
        strokeWidth: 2,
        pathBackgroundColor: Colors.black,
      ),
    );
  }
}
