import 'dart:convert' as convert;

import 'package:feex/components/default_button.dart';
import 'package:feex/constants.dart';
import 'package:feex/providers/customer_details_provider.dart';
import 'package:feex/screens/login/login_screen.dart';
import 'package:feex/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:feex/auth/auth_functions.dart';


class UserChangePassword extends StatefulWidget {
  @override
  State<UserChangePassword> createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  final _currentPasswordController = TextEditingController();

  final _newPasswordController1 = TextEditingController();

  final _newPasswordController2 = TextEditingController();

  Map<String, dynamic> _passwordDetails = {
    'current_password': '',
    'passwrod': '',
    'password2': ''
  };

  Map<String, dynamic> _errorMap = {
    'current_password': '',
    'passwrod': '',
    'password2': ''
  };

  changePassword(paswordDetails, customerId) async {
    String url =
        'https://feex.herokuapp.com/api/account/change_password/$customerId/';

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('access_token');

    if (accessToken == 'null') return; //breakpoint

    var response = await http.put(Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: paswordDetails);

    Map<String, dynamic> responseMap = {};

    if (response.statusCode == 200) {
      responseMap['statusCode'] = 200;
      return responseMap;
    } else if (response.statusCode == 400) {
      responseMap['statusCode'] = 400;
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      for (var item in jsonResponse.keys) {
        if (item == 'current_password') {
          setState(() {
            _errorMap[item] = jsonResponse[item][item];
          });
        }
        setState(() {
          _errorMap[item] = jsonResponse[item];
        });
      }

      return responseMap;
    } else {
      responseMap['statusCode'] == 500;
      return responseMap;
    }
  }

  credentialsFeild(
      controller, hintText, errorText, obscureText, feildIcon, feildName) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.start,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return 'please enter $hintText';
      },
      onChanged: (value) {
        _passwordDetails[feildName] = value;
        setState(() {
          _errorMap[feildName] = '';
        });
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        errorText: _errorMap[feildName] == ''
            ? null
            : _errorMap[feildName].toString().trimRight(),
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
      body: Consumer<CustomerDetailsProvider>(builder: (_, value, __) {
        return Container(
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
              credentialsFeild(_currentPasswordController, 'Current Password',
                  false, false, null, 'current_password'),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              credentialsFeild(_newPasswordController1, 'New Password', false,
                  false, null, 'password'),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              credentialsFeild(_newPasswordController2, 'Confirm Password',
                  false, false, null, 'password2'),
              SizedBox(
                height: SizeConfig.screenHeight * 0.3,
              ),
              DefaultButton(
                text: 'Save',
                press: () async {
                  bool error = false;
                  Map errorMap = {};
                  var v = {};
                  await changePassword(
                          _passwordDetails, value.customerDetailsModel.id)
                      .then((response) {
                    v = response;
                  });
                  if (v['statusCode'] == 200) {
                    await AuthMethods().logOutUser();
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.routeName, (route) => false);
                  } else if (v['statusCode'] == 400) {
                    error = true;
                    // errorMap = v['response'];
                  } else {
                    error = true;
                  }
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
