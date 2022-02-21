import 'dart:async';

import 'package:feex/constants.dart';
import 'package:feex/main.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:feex/screens/login/login_screen.dart';
import 'package:feex/screens/splash/splash_components/splash_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../size_config.dart';
import 'package:feex/auth/auth_functions.dart';

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
    var screenToPush;
    if (_seen) {
      await AuthMethods().getAccessToken().then((hasAccessToken) {
        if (hasAccessToken) {
          screenToPush = HomeScreen();
        } else {
          screenToPush = LoginScreen();
        }
      });
    } else {
      await prefs.setBool('seen', true); //set flag true
      screenToPush = Body();
    }
    return screenToPush;
  }

  void initState() {
    super.initState();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;

    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         'Haale luia',
    //         notification.body,
    //         NotificationDetails(
    //             android: AndroidNotificationDetails(
    //           channel.id,
    //           'Haale lyia',
    //           channelDescription: channel.description,
    //           color: kPrimaryColor,
    //         )));
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text('Haale luia'),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [Text(notification.body!)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });

    Timer(const Duration(seconds: 2), () async {
      checkFirstSeen().then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => value));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    // it builds all the size configs used throughout the app
    // very important to initialize it
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff211452),
      body: Center(
        child: SvgPicture.asset('assets/images/frame_white.svg'),
      ),
    );
  }
}
