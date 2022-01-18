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
        Uri.parse('https://feex.herokuapp.com/api/account/login/'),
        body: body);
    jsonResponse = await json.decode(res.body);
    if (res.statusCode == 200) {
      if (jsonResponse != null) {
        await sharedPreferences.setString(
            "access_token", jsonResponse['access']);

        return 'true';
      }
    } else {
      return jsonResponse['detail'];
    }
  }

  getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var containesAccessTokenKey = sharedPreferences.containsKey('access_token');
    if (containesAccessTokenKey == false) {
      return false; // returns false if access_token key D.N.E.
    } else {
      var accessTokenValue = sharedPreferences.getString('access_token');
      if (accessTokenValue == 'null') {
        return false; // returns false if access_token exists but is NULL
      } else {
        return true; // return true if access_token exists and is not NULL
        //implying access_token of a genuine user exits
      }
    }
  }

  logOutUser() async {
    bool hasError = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences
        .remove('access_token')
        .onError((error, stackTrace) => hasError = true);
    return hasError;
  }

  guestUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Setting access_token key to null for guest session
    await sharedPreferences.setString('access_token', 'null');
  }
}
