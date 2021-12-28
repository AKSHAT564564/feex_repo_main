import 'dart:async';

import 'package:feex/screens/login/login_screen.dart';
import 'package:feex/screens/splash/splash_components/splash_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../size_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // setting up a flag for first time install
  // when set true will not show the splash screen crousel
  // for first time install only
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen)
      return LoginScreen();
    else {
      await prefs.setBool('seen', true); //set flag true
      return Body();
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 2), () async {
      checkFirstSeen().then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => value));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen

    return Scaffold(
      backgroundColor: Color(0xff211452),
      body: Center(
        child: SvgPicture.asset('assets/images/frame_white.svg'),
      ),
    );
  }
}
