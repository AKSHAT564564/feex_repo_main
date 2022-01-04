import 'package:feex/auth/auth_functions.dart';
import 'package:feex/components/default_button.dart';
import 'package:feex/components/no_account_text.dart';
import 'package:feex/helper/keyboard.dart';
import 'package:feex/screens/forgot_password/reset_password_page.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:feex/auth/auth_functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  String? email;

  String? password;

  bool _isLoading = false;

  bool emailError = false, passwordError = false;

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
        contentPadding: const EdgeInsets.all(8),
        prefixIcon: feildIcon,
        errorText: errorText ? 'Check $hintText' : null,
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: ListView(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                Row(children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
                    child: const Text(
                      "Skip for now",
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 16,
                        // decoration: TextDecoration.underline
                      ),
                    ),
                  )
                ]),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
                ),
                Image.asset(
                  'assets/images/frame_blue.png',
                  height: SizeConfig.screenHeight * 0.08,
                  width: SizeConfig.screenWidth * 0.4,
                ),

                SizedBox(height: SizeConfig.screenHeight * 0.1),
                // SizedBox(
                //   height: getProportionateScreenHeight(10),
                // ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      credentialsFeild(
                          _emailController,
                          'Username',
                          emailError,
                          false,
                          const Icon(
                            Icons.person_outline_sharp,
                            color: Color(0xff211452),
                          )),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      credentialsFeild(
                          _passwordController,
                          'Password',
                          passwordError,
                          true,
                          const Icon(
                            Icons.lock_outline,
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
                                  .login(_emailController.text,
                                      _passwordController.text)
                                  .then((value) {
                                if (value == 'true') {
                                  Navigator.pushNamed(
                                      context, HomeScreen.routeName);
                                } else {
                                  // Showing alert dialog for error
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Alert(
                                    context: context,
                                    type: AlertType.info,
                                    title: 'Login Failed',
                                    desc: value.toString(),
                                    buttons: [
                                      DialogButton(
                                        child: const Text(
                                          "Try Again",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: Color.fromRGBO(0, 179, 134, 1.0),
                                      ),
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
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
