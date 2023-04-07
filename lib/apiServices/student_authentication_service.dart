import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseurl = dotenv.get('END_URL');
class StudentAPIAuthentication{
  static Future<bool> signUpAdmin(String email, String collageName,
      String password) async {
    try {
      String url = '$baseurl/create/student/';

      var body = jsonEncode({
        'email': email,
        'password': password,
        'collage': collageName,
      });

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
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<String> studentLogin(String username, String password) async {
    try {
      String url = '$baseurl/tokenforstudent/';
      var response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        },
      );

      if (response.statusCode == 307) {
        // Follow the redirect to the new URL
        var redirectUrl = response.headers['location'];
        response = await http.post(Uri.parse(redirectUrl!), body: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        });
      }

      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        return 'Not Found';
      }
    } catch (e) {
      throw e.toString();
    }
  }

}