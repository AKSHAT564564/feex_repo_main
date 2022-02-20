import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class ResetPasswordSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.15),
              Stack(
                children: [
                  SvgPicture.asset('assets/images/check_icon.svg'),
                  Image.asset('assets/images/check_icon_dots.png')
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.09),
            const  Text(
                'Check Your Inbox',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: SizeConfig.screenWidth * 0.07,
              ),
              Text(
                "We sent you reset link",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: kSecondaryColor,
                ),
              ),
              Text(
                "check your email for the instructions",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: kSecondaryColor,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.22,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.8,
                child: DefaultButton(
                  text: "Log in Page",
                  press: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
