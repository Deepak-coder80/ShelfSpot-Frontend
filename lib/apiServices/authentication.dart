import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseurl = dotenv.get('END_URL');

class APIAuthentication {
  static Future<String> adminLogin(String username, String password) async {
    try {
      log("email $username, password $password");
      String url = '$baseurl/token/';
      var response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        },
      );

      log(response.statusCode.toString());

      if (response.statusCode == 307) {
        // Follow the redirect to the new URL
        var redirectUrl = response.headers['location'];
        response = await http.post(Uri.parse(redirectUrl!), body: {
          'username': username,
          'password': password,
          'grant_type': 'password',
        });
      } else {
        response = response;
      }

      log('comes here ${response.body}');

      if (response.statusCode == 200) {
        log("Entered here");
        return response.body.toString();
      } else {
        return 'Not Found';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
