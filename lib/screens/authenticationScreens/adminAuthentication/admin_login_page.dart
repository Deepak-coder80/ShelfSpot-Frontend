import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelfspot/apiServices/authentication.dart';
import 'package:shelfspot/components/alertboxes/alertbox.dart';
import 'package:shelfspot/components/alertboxes/signup_alert_box.dart';
import 'package:shelfspot/components/buttonComponents/login_button.dart';
import 'package:shelfspot/components/buttonComponents/signup_text_button.dart';
import 'package:shelfspot/components/textFieldComponents/password_text_field.dart';
import 'package:shelfspot/components/textFieldComponents/text_input_field.dart';
import 'package:shelfspot/screens/usersPages/admin_home.dart';

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

  Future<String> fetchData() async {
    try {
      String result = await APIAuthentication.adminLogin(
          _emailController.text, _passwordController.text);
      if (result != 'Not Found') {
        return result;
      } else {
        throw Exception('User is Not Found');
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
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/applogo.png'),
              const SizedBox(
                height: 52,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextInputField(
                  text: ' Email Address',
                  controller: _emailController,
                  iconData: Icons.email_outlined,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordTextField(
                  text: 'Enter password',
                  controller: _passwordController,
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              SizedBox(
                height: 80,
                width: 200,
                child: LoginButton(
                  text: 'Log In',
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
                    } else if (!EmailValidator.validate(_emailController.text)) {
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
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: SizedBox(
                              height: 90,
                              width: 90,
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballRotateChase,
                                  colors:  [Color(0xFFFFC700)],       /// Optional, The color collections
                                  strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                                  pathBackgroundColor: Colors.black,
                              ),
                            ),
                          );
                        },
                      );

                      fetchData().then((data) async {
                        Navigator.of(context).pop();
                        Map<String, dynamic> decodeToken =
                            JwtDecoder.decode(data);
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setString("email", decodeToken['email']);
                        pref.setString("collage", decodeToken['collage']);
                        pref.setBool("isAdmin", true);
                        _emailController.clear();
                        _passwordController.clear();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const AdminHomePage()),
                          (route) => false,
                        );
                      }).catchError((error) {
                        _passwordController.clear();
                        Navigator.of(context).pop();
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) => const AlertBox(
                            title: 'User Not Found',
                            content: 'Please check your credentials once again. ',
                          ),
                        );
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SignUpTButton(
                text1: 'New to here?',
                text2: 'Sign Up',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpAlertBox()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
