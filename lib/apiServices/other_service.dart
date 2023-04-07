import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String baseurl = dotenv.get('END_URL');

class OtherAPIServices{
  static Future<List<String>> getAllCollageList() async{
    String url = '$baseurl/collages/';

    var response =await http.get(Uri.parse(url));

    if (response.statusCode == 307){
      var redirectUrl = response.headers['location'];
      response =await http.get(Uri.parse(redirectUrl!));
    }

    if(response.statusCode==200){
      List<String> collages = (json.decode(response.body) as List)
        .map((e) => e.toString())
        .toList();
      return collages;
    }else{
      log('not success');
    }
    return [];
  }
}