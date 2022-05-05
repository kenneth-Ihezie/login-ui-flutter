import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_ui/model/Http_Response.dart';


class Api{
   Future<HttpResponse> getUserStatus(String email, String password) async {
        final response = await http.get(Uri.parse("https://hrsoftware.bivisoft.com/api/login?email=$email&pass=$password"));
        if(response.statusCode == 200){
           return HttpResponse.fromJson(jsonDecode(response.body));
        } else {
          //handle error.
        }
   }
}