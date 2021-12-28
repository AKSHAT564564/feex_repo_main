import 'package:feex/components/no_account_text.dart';
import 'package:feex/screens/home_screen/home_screen.dart';
import 'package:feex/screens/login/components/login_form.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
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
                  height: SizeConfig.screenHeight * 0.10,
                  width: SizeConfig.screenWidth * 0.5,
                ),
                // Text(
                //   "FEEX .",
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: getProportionateScreenWidth(32),
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                // SizedBox(
                //   height: getProportionateScreenHeight(10),
                // ),
                LoginForm(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                  // child: Container(
                  //   color: Colors.green,
                  // ),
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
