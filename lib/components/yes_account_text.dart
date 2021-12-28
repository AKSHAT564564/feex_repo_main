import 'package:feex/screens/login/login_screen.dart';
import 'package:feex/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class YesAccountText extends StatelessWidget {
  const YesAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, LoginScreen.routeName),
          child: Text(
            "Log in",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: greenColor),
          ),
        ),
      ],
    );
  }
}