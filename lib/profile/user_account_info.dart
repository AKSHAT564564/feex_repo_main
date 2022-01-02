import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';

class UserAccountInfo extends StatelessWidget {
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
          'Account Information',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(25)),
            credentialsFeild(
                _emailController, 'First Name', false, false, null),
            SizedBox(height: getProportionateScreenHeight(25)),
            credentialsFeild(_emailController, 'Last Name', false, false, null),
            SizedBox(height: getProportionateScreenHeight(25)),
            credentialsFeild(_emailController, 'Email', false, false, null),
            SizedBox(height: getProportionateScreenHeight(25)),
            credentialsFeild(
                _emailController,
                'Date of birth',
                false,
                false,
                const Icon(
                  Icons.calendar_today_outlined,
                  color: kPrimaryColor,
                )),
            SizedBox(height: getProportionateScreenHeight(25)),
            const Text(
              'Gender (optional)',
              style: TextStyle(color: kSecondaryColor),
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Radio(
                        value: 'value', groupValue: 'gValue', onChanged: null),
                    Text(
                      'Male',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
                Row(
                  children: const [
                    Radio(
                        value: 'value', groupValue: 'gValue', onChanged: null),
                    Text(
                      'Female',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: DefaultButton(
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
