import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfspot/apiServices/other_service.dart';
import 'package:shelfspot/apiServices/student_authentication_service.dart';
import 'package:shelfspot/components/alertboxes/alertbox.dart';
import 'package:shelfspot/components/buttonComponents/login_button.dart';
import 'package:shelfspot/components/buttonComponents/signup_text_button.dart';
import 'package:shelfspot/components/textFieldComponents/password_text_field.dart';
import 'package:shelfspot/components/textFieldComponents/text_input_field.dart';
import 'package:shelfspot/screens/authenticationScreens/adminAuthentication/admin_signup_page.dart';
import 'package:shelfspot/screens/authenticationScreens/login_page.dart';

class StudentSignUpPage extends StatefulWidget {
  const StudentSignUpPage({Key? key}) : super(key: key);

  @override
  State<StudentSignUpPage> createState() => _StudentSignUpPageState();
}

class _StudentSignUpPageState extends State<StudentSignUpPage> {
  late Future<List<String>> collageList;
  String? dropDownValue;
  late TextEditingController _emailController;
  late TextEditingController _collageController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    collageList = OtherAPIServices.getAllCollageList();
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

  Future<bool> fetchData(String collage) async {
    try {
      bool result = await StudentAPIAuthentication.signUpAdmin(
        _emailController.text,
        collage,
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
        title:  const Text('Shelf Spot Student'),
        backgroundColor: const Color(0xFF201F15),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: collageList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
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
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: buildCollageDropDown(snapshot),
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
                        onPressed: () {
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
                                content:
                                    'Password and confirm password should match',
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
                            fetchData(dropDownValue!).then(
                              (data) {
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LogInPage()),
                                    (route) => false);
                                const snackBar = SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                      'Signed Up Successfully. Please Login'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
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
                );
              } else if (snapshot.hasError) {
                return AlertBox(
                  title: "Something error happened",
                  content: snapshot.error.toString(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFFC700),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCollageDropDown(AsyncSnapshot<List<String>> snapshot) {
    List<String> collageList = snapshot.data!;
    collageList = collageList.toSet().toList(); // Remove duplicates
    collageList.sort();
    dropDownValue ??= collageList.first;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(
            color: const Color(0xFFFFC700),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: DropdownButton(
            hint: const Text(
              'Please select your collage',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: const Icon(
              FontAwesomeIcons.caretDown,
              color: Color(0xFFFFC700),
              size: 26,
            ),
            underline: Container(
              color: Colors.transparent,
            ),
            isExpanded: true,
            value: dropDownValue,
            items: collageList
                .map(
                  (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value.toUpperCase(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            )
                .toList(),
            onChanged: (String? value) {
              setState(() {
                dropDownValue = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
