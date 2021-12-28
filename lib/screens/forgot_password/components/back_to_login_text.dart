import 'package:feex/screens/login/login_screen.dart';
import 'package:feex/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class BackToLoginText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "you know your password? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        Text(
          "back to ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, LoginScreen.routeName),
          child: Text(
            "Log In",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: greenColor),
          ),
        ),
      ],
    );
  }
}