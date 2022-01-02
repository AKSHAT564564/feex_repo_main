import 'package:feex/auth/auth_functions.dart';
import 'package:feex/components/default_button.dart';
import 'package:feex/components/yes_account_text.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:feex/screens/sign_up/components/sign_up_form.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Map<String, dynamic> _userDetails = {
    'email': '',
    'password': '',
    'password2': '',
    'username': '',
    'mobile_number': ''
  };

  Map<String, dynamic> _errors = {
    'email': '',
    'password': '',
    'password2': '',
    'username': '',
    'mobile_number': ''
  };

  registerUser(Map<String, dynamic> userDetails) async {
    var jsonResponse;
    var res = await http.post(
        Uri.parse('https://feex.herokuapp.com/api/auth/register/'),
        body: userDetails);
    Map<String, dynamic> response = convert.jsonDecode(res.body);

    if (res.statusCode == 201) {
      await AuthMethods()
          .login(response['email'], _passwordController.text)
          .then((v) {
        Navigator.pushNamed(context, HomeScreen.routeName);
      });
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      for (var item in response.keys) {
        setState(() {
          _errors[item] = response[item];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            // width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%

                  SvgPicture.asset(
                    'assets/images/frame_blue.svg',
                    height: SizeConfig.screenHeight * 0.08,
                    width: SizeConfig.screenWidth * 0.4,
                  ),

                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        credentialsFeild(
                            _nameController, 'Name', false, false, 'username'),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        credentialsFeild(
                            _emailController, 'Email', false, false, 'email'),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        credentialsFeild(_mobileController, 'Mobile', false,
                            false, 'mobile_number'),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        credentialsFeild(_passwordController, 'Password', false,
                            true, 'password'),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        credentialsFeild(_confirmPasswordController,
                            'Confirm Password', false, true, 'password2'),
                        // FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(40)),
                        DefaultButton(
                          text: "Create Account",
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() {
                                _isLoading = true;
                              });
                              await registerUser(_userDetails);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  YesAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  credentialsFeild(controller, hintText, errorText, obscureText, feildName) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: feildName != 'mobile_number'
          ? TextInputType.emailAddress
          : TextInputType.phone,
      textAlign: TextAlign.start,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty)
          return 'please enter $hintText';
        else if ((feildName == 'password' || feildName == 'password2')) {
          if (value.length < 8) {
            return 'Password strength should be 8';
          } else if (value.contains(RegExp(r'^-?[0-9]+$')) == true) {
            return 'Password must include atleast 1 letter';
          } else if (feildName == 'password2' &&
              _passwordController.text != value) {
            return 'Password does not Match!';
          }
        }
      },
      onChanged: (value) {
        _userDetails[feildName] = controller.text;
        setState(() {
          _errors[feildName] = '';
        });
      },
      onFieldSubmitted: (value) {
        _userDetails[feildName] = value;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10),
        errorText:
            _errors[feildName] == '' ? null : _errors[feildName].toString(),
        focusColor: Colors.grey,
        hintText: hintText,
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
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
    );
  }
}
