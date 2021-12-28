import 'package:flutter/material.dart';

import 'components/login_body.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Body()),
    );
  }
}
