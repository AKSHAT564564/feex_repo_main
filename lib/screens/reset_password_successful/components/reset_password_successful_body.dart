import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/splash1.jpg",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(24),
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        Spacer(),
        Text(
          "We sent you reset link",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        Spacer(),
        Text(
          "check your email for the instructions",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Log in Page",
            press: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}