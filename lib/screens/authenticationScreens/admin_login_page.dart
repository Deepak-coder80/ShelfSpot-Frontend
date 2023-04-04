import 'dart:developer';
import 'package:flutter/material.dart';
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
                onPressed: () {
                  log("email = ${_emailController.text} and password = ${_passwordController.text}");
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




