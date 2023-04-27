import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelfspot/apiServices/qn_paper_services.dart';
import 'package:shelfspot/components/alertboxes/alertbox.dart';
import 'package:shelfspot/components/buttonComponents/login_button.dart';
import 'package:shelfspot/models/qn_paper_model.dart';
import 'package:shelfspot/screens/usersPages/adminPages/admin_home.dart';

class QPAddScreen extends StatefulWidget {
  const QPAddScreen({Key? key}) : super(key: key);

  @override
  State<QPAddScreen> createState() => _QPAddScreenState();
}

class _QPAddScreenState extends State<QPAddScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _subjectName;
  late TextEditingController _month;
  late TextEditingController _scheme;
  late TextEditingController _semester;
  late TextEditingController _year;
  late TextEditingController _link;
  late TextEditingController _collage;

  @override
  void initState() {
    _subjectName = TextEditingController();
    _month = TextEditingController();
    _scheme = TextEditingController();
    _semester = TextEditingController();
    _year = TextEditingController();
    _link = TextEditingController();
    _collage = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _subjectName.dispose();
    _month.dispose();
    _scheme.dispose();
    _semester.dispose();
    _year.dispose();
    _link.dispose();
    _collage.dispose();
    super.dispose();
  }

  Future<bool> fetchData(QuestionPaperAddRequestModel qn) async {
    try {
      bool result = await QnPaperAPIServices.addQuestionPaper(qn);

      if (result == true) {
        return result;
      } else {
        throw Exception("Can't Add Question Paper! Some error Occurred");
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
        title: const Text('Add Question Paper'),
        elevation: 0,
        backgroundColor: const Color(0xFFFFC700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.white38,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: 'Subject Name',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a subject name';
                      }
                      return null;
                    },
                    controller: _subjectName,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.white38,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: 'Year of Question Paper',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a year of Question Paper';
                      }
                      return null;
                    },
                    controller: _year,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.white38,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: 'Month of Question Paper',
                      hintText: 'E.g. September',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white38,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a month';
                      }
                      return null;
                    },
                    controller: _month,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.white38,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: 'Scheme',
                      hintText: 'E.g. 2019',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white38,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a scheme';
                      }
                      return null;
                    },
                    controller: _scheme,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.white38,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: 'Semester',
                      hintText: 'E.g. 5',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white38,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a semester';
                      }
                      return null;
                    },
                    controller: _semester,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.white38,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Color(0xFFFFC700),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: 'Link to Question Paper',
                      hintText: 'Make sure that it is  publicly accessible',
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white38,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a link';
                      }
                      return null;
                    },
                    controller: _link,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: SizedBox(
                        height: 80,
                        width: 150,
                        child: LoginButton(
                          text: 'Submit',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();

                              _collage.text = pref.getString("collage")!;

                              QuestionPaperAddRequestModel qn =
                                  QuestionPaperAddRequestModel(
                                qnSubName: _subjectName.text,
                                collage: _collage.text,
                                qnLink: _link.text,
                                qnMonth: _month.text,
                                qnScheme: int.parse(_scheme.text),
                                qnSemester: int.parse(_semester.text),
                                qnYear: int.parse(_year.text),
                              );

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: SizedBox(
                                      height: 90,
                                      width: 90,
                                      child: LoadingIndicator(
                                        indicatorType:
                                            Indicator.ballRotateChase,
                                        colors: [Color(0xFFFFC700)],

                                        /// Optional, The color collections
                                        strokeWidth: 2,

                                        /// Optional, The stroke of the line, only applicable to widget which contains line
                                        pathBackgroundColor: Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              );

                              fetchData(qn).then(
                                (data) {
                                  Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminHomePage()),
                                      (route) => false);
                                  const snackBar = SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                        'Qp Added Successfully. Please Login'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              ).catchError((error) {
                                Navigator.of(context).pop();
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertBox(
                                    title: 'QP adding unsuccessful',
                                    content:
                                    'Please check your credentials once again and Try again',
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
