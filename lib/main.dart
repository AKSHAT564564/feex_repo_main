import 'package:feex/constants.dart';
import 'package:feex/routes.dart';
import 'package:feex/screens/login/login_screen.dart';
import 'package:feex/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          hintColor: lightBlueColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: kPrimaryColor),
            bodyText2: TextStyle(color: kSecondaryColor),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
