import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthMethods {
  login(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"email": email, "password": password};
    var jsonResponse;
    var res = await http.post(
        Uri.parse('https://feex.herokuapp.com/api/auth/login/'),
        body: body);
    jsonResponse = json.decode(res.body);
    if (res.statusCode == 200) {
      if (jsonResponse != null) {
        sharedPreferences.setString("access_token", jsonResponse['access']);

        return 'true';
      }
    } else
      return jsonResponse['detail'];
  }

  getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey('access_token');
  }

  logOutUser() async {
    bool hasError = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences
        .remove('access_token')
        .onError((error, stackTrace) => hasError = true);
    return hasError;
  }
}
