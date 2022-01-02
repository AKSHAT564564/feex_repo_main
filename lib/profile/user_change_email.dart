import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class UserChangeEmail extends StatelessWidget {
  final _emailController = TextEditingController();

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
        focusColor: kBorderGreyColor,
        hintText: hintText,
        suffixIcon: feildIcon,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: kBorderGreyColor, width: 1),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: kBorderGreyColor, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
          borderSide: BorderSide(color: kBorderGreyColor, width: 1),
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
          'Change Emial',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  'Current Email: ',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Joseph@feexapp.com',
                  style: TextStyle(color: kSecondaryColor),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text('To Update your email Plase fill the following details:'),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            credentialsFeild(_emailController, 'New Email', false, false, null),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            credentialsFeild(
                _emailController, 'Account Password', false, true, null),
            SizedBox(
              height: SizeConfig.screenHeight * 0.35,
            ),
            Center(
              child: Container(
                width: SizeConfig.screenWidth * 0.8,
                child: const DefaultButton(
                  text: 'Save',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
