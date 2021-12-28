import 'package:feex/screens/forgot_password/reset_password_page.dart';
import 'package:feex/screens/login/login_screen.dart';
import 'package:feex/screens/sign_up/sign_up_screen.dart';
import 'package:feex/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen/home_screen.dart';
import 'screens/reset_password_successful/reset_password_successful_page.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  ResetPasswordSuccessScreen.routeName: (context) => ResetPasswordSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),

  // ProfileScreen.routeName: (context) => ProfileScreen(),
};