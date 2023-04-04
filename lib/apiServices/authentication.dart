import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String url = dotenv.get('END_URL');

class APIAuthentication {
  static Future<String> adminLogin(String username, String password) async {
    url += 'token/';
    var response = await http.post(
      Uri.parse('https://shelf-spot-api2.onrender.com/token/'),
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
      return  response.body.toString();
    }else if(response.statusCode==404) {
      return 'Not Found';
    }else {
      return 'Something Wrong Happened';
    }

  }
}
