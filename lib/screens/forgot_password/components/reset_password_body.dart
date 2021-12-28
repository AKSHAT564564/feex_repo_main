import 'package:feex/components/default_button.dart';
import 'package:feex/screens/reset_password_successful/reset_password_successful_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'back_to_login_text.dart';

class Body extends StatelessWidget {
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:SizedBox(
        width: double.infinity,
        child:  Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
                ),
                Text(
                  "FEEX .",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.13),
                Text(
                  "Reset Password",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenWidth(26),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text(
                  "Email your email to get the reset password link, check spam folder if you didn't receive it",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                buildEmailFormField(),
                SizedBox(height: SizeConfig.screenHeight * 0.25),
                DefaultButton(
                  text: "Reset",
                  press: () {
                    Navigator.pushNamed(context, ResetPasswordSuccessScreen.routeName);
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                BackToLoginText(),
              ],
            ),
          ),
        ),
      )
    );
  }
  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kEmailNullError);
        // } else if (emailValidatorRegExp.hasMatch(value)) {
        //   removeError(error: kInvalidEmailError);
        // }
        // return null;
      },
      validator: (value) {
        // if (value!.isEmpty) {
        //   addError(error: kEmailNullError);
        //   return "";
        // } else if (!emailValidatorRegExp.hasMatch(value)) {
        //   addError(error: kInvalidEmailError);
        //   return "";
        // }
        // return null;
      },
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightBlueColor, width: 1.0),
        ),
        // labelText: "Email",
        hintText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}

