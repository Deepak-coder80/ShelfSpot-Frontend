import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shelfspot/models/qn_paper_model.dart';

String baseurl = dotenv.get('END_URL');

class QnPaperAPIServices {
  static Future<List<QnPaperModel>?> getQuestionPaperBySemester(
      String semester,String collage) async {
    String url = '$baseurl/qPaperSem/';

    var body = jsonEncode({"semester": semester, "collage": collage});

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 307) {
      var redirectUrl = response.headers['location'];
      response = await http.post(
        Uri.parse(redirectUrl!),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );
    }

    if (response.statusCode == 200) {
      List<QnPaperModel> qnPapers = (json.decode(response.body) as List)
          .map((e) => QnPaperModel(
                name: e['qnSubName'],
                semester: e['qnSemester'],
                month: e['qnMonth'],
                year: e['qnYear'],
                link: e['qnLink'],
                scheme: e['qnScheme'],
              ))
          .toList();

      return qnPapers;
    }

    return null;
  }

  static Future<List<QnPaperModel>?> getQuestionPaperByName(
      String name,String collage) async {
    String url = '$baseurl/qPaperSub/';

    var body = jsonEncode({"name": name, "collage": collage});

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 307) {
      var redirectUrl = response.headers['location'];
      response = await http.post(
        Uri.parse(redirectUrl!),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );
    }

    if (response.statusCode == 200) {
      List<QnPaperModel> qnPapers = (json.decode(response.body) as List)
          .map((e) => QnPaperModel(
        name: e['qnSubName'],
        semester: e['qnSemester'],
        month: e['qnMonth'],
        year: e['qnYear'],
        link: e['qnLink'],
        scheme: e['qnScheme'],
      )).toList();

      return qnPapers;
    }

    return null;
  }

  static Future<bool> addQuestionPaper(QuestionPaperAddRequestModel qn) async{
    try{
      String url = '$baseurl/add_qn_paper/';

      var body = jsonEncode(
        {
          "qnSubName": qn.qnSubName,
          "qnMonth": qn.qnMonth,
          "qnScheme": qn.qnScheme,
          "qnSemester": qn.qnSemester,
          "qnYear": qn.qnYear,
          "qnLink": qn.qnLink,
          "collage": qn.collage
        }
      );

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 307) {
        // Follow the redirect to the new URL
        var redirectUrl = response.headers['location'];
        response = await http.post(
          Uri.parse(redirectUrl!),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: body,
        );
      }

      if(response.statusCode == 200){
        return true;
      }

      return false;
    }catch(e){
      return false;
    }
  }
}
