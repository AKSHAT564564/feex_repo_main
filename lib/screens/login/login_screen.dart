import 'package:feex/auth/auth_functions.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'components/login_body.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AuthMethods().getAccessToken().then((hasAccessToken) {
      if (hasAccessToken) {
        Timer(const Duration(seconds: 2), () async {
          Navigator.pushNamed(context, HomeScreen.routeName);
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(inAsyncCall: _isLoading, child: Body()),
    );
  }
}
