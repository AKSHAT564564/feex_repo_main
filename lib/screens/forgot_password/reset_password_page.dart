import 'package:feex/components/default_button.dart';
import 'package:feex/screens/login/login_screen.dart';
import 'package:feex/screens/reset_password_successful/reset_password_successful_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  final _emailController = TextEditingController();
  bool emailError = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
                ),
                SvgPicture.asset(
                  'assets/images/frame_blue.svg',
                  height: SizeConfig.screenHeight * 0.10,
                  width: SizeConfig.screenWidth * 0.5,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.09),
                Text(
                  "Reset Password",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenWidth(32),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text(
                  "Email your email to get the reset password link, check spam folder if you didn't receive it",
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: getProportionateScreenWidth(16),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                credentialsFeild(
                    _emailController,
                    'Email',
                    emailError,
                    false,
                    const Icon(
                      Icons.lock,
                      color: Color(0xff211452),
                    )),
                SizedBox(height: SizeConfig.screenHeight * 0.25),
                DefaultButton(
                  text: "Reset",
                  press: () {
                    Navigator.pushNamed(
                        context, ResetPasswordSuccessScreen.routeName);
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "you know your password? ",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(16)),
                    ),
                    Text(
                      "back to ",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(16)),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, LoginScreen.routeName),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            color: greenColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  credentialsFeild(
      controller, hintText, errorText, obscureText, Icon feildIcon) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.start,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return 'please enter $hintText';
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        prefixIcon: feildIcon,
        errorText: errorText ? 'Check $hintText' : null,
        focusColor: Colors.grey,
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.5),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 3),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.5),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 3),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.5),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 3),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.5),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
    );
  }
}
