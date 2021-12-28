import 'dart:convert';

import 'package:feex/auth/auth_functions.dart';
import 'package:feex/components/form_error.dart';
import 'package:feex/helper/keyboard.dart';
import 'package:feex/screens/forgot_password/reset_password_page.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? email;
  String? password;
  // bool? remember = false;
  bool _isLoading = false;
  bool emailError = false, passwordError = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          credentialsFeild(
              _emailController,
              'Username',
              emailError,
              false,
              Icon(
                Icons.person,
                color: Color(0xff211452),
              )),
          SizedBox(height: getProportionateScreenHeight(30)),
          credentialsFeild(
              _passwordController,
              'Password',
              passwordError,
              true,
              Icon(
                Icons.lock,
                color: Color(0xff211452),
              )),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(fontSize: 16, color: greenColor
                      // decoration: TextDecoration.underline
                      ),
                ),
              )
            ],
          ),
          // FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Log In",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                if (_emailController.text == '' ||
                    _passwordController.text == '') {
                  setState(() {
                    emailError = true;
                    passwordError = true;
                  });
                } else {
                  setState(() {
                    _isLoading = true;
                  });
                  await AuthMethods()
                      .login(_emailController.text, _passwordController.text)
                      .then((value) {
                    if (value == 'true') {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    } else {
                      // Showing alert dialog for error
                      Alert(
                        context: context,
                        type: AlertType.info,
                        title: 'Login Failed',
                        desc: value.toString(),
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "Try Again",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {},
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                          ),
                          DialogButton(
                            child: Text(
                              "NO",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(116, 116, 191, 1.0),
                              Color.fromRGBO(52, 138, 199, 1.0)
                            ]),
                          )
                        ],
                      ).show();
                    }
                  });
                }

                // Navigator.pushNamed(context, HomeScreen.routeName);
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }

  //created a single function for multiple widgets

  credentialsFeild(
      controller, hintText, errorText, obscureText, Icon feildIcon) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.055,
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: TextInputType.emailAddress,
        textAlign: TextAlign.start,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) return 'please enter $hintText';
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
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
      ),
    );
  }
}
