import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelfspot/apiServices/authentication.dart';
import 'package:shelfspot/components/buttonComponents/login_button.dart';
import 'package:shelfspot/components/buttonComponents/signup_text_button.dart';
import 'package:shelfspot/components/textFieldComponents/password_text_field.dart';
import 'package:shelfspot/components/textFieldComponents/text_input_field.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  // Controllers
  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/applogo.png'),
              const SizedBox(
                height: 52,
              ),
              TextInputField(
                text: ' Email Address',
                controller: _emailController,
                iconData: Icons.email_outlined,
              ),
              const SizedBox(
                height: 42,
              ),
              PasswordTextField(
                text: 'Enter password',
                controller: _passwordController,
              ),
              const SizedBox(
                height: 42,
              ),
              LoginButton(
                text: 'Log In',
                onPressed: () async {
                  if (_emailController.text.isEmpty) {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (context) => const AlertBox(
                        title: 'Email Can\'t be Empty' ,
                        content: 'Please Enter a email',
                      ),
                    );
                  }else if(!EmailValidator.validate(_emailController.text)){
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
                  } else {
                    String result = await APIAuthentication.adminLogin(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (result == 'Not Found') {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => const AlertBox(
                          title: 'User Not Found',
                          content: 'Please check your credentials once again',
                        ),
                      );
                    } else if (result == 'Something Wrong Happened') {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => const AlertBox(
                          title: 'Something went wrong',
                          content: 'Please check your credentials once again',
                        ),
                      );
                    } else {
                      Map<String,dynamic> decodeToken = JwtDecoder.decode(result);
                      log(decodeToken.keys.toString());
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setString("email", decodeToken['email']);
                      pref.setString("collage", decodeToken['collage']);
                      pref.setBool("isAdmin", true);
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const SignUpTButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertBox extends StatelessWidget {
  final String title;
  final String content;

  const AlertBox({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF201F15),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      content: Text(
        content,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Color(0xFFFFC700)),
          ),
        )
      ],
    );
  }
}
