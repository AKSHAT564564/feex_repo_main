import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class UserChangePassword extends StatelessWidget {
  final _passwordController = TextEditingController();

  credentialsFeild(controller, hintText, errorText, obscureText, feildIcon) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.start,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return 'please enter $hintText';
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        errorText: errorText ? 'Check $hintText' : null,
        focusColor: Colors.grey,
        hintText: hintText,
        suffixIcon: feildIcon,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(
            color: kBorderGreyColor,
            width: 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            )),
        elevation: 1,
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            const Text(
              'To update your password please fill the following details:',
              style: TextStyle(color: kSecondaryColor),
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            credentialsFeild(
                _passwordController, 'Current Password', false, false, null),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            credentialsFeild(
                _passwordController, 'New Password', false, false, null),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            credentialsFeild(
                _passwordController, 'Confirm Password', false, false, null),
            SizedBox(
              height: SizeConfig.screenHeight * 0.3,
            ),
            const DefaultButton(
              text: 'Save',
              press: null,
            )
          ],
        ),
      ),
    );
  }
}
